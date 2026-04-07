package com.grownited.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.grownited.entity.UserEntity;
import com.grownited.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

/**
 * User management — Profile, Settings, Admin user-list, Toggle active/inactive.
 *
 * Routes:
 *   GET  /profile                   → view/edit own profile
 *   POST /profile/update            → save profile changes
 *   POST /profile/change-password   → change password
 *   POST /profile/deactivate        → self-deactivate
 *   POST /profile/delete            → permanent self-delete
 *   GET  /settings                  → settings page
 *
 *   Admin only:
 *   GET  /listuser                  → all users
 *   GET  /viewuser                  → view single user
 *   GET  /deleteuser                → hard-delete user
 *   POST /toggleuser                → flip active flag
 */
@Controller
public class UserController {

    @Autowired private UserRepository  userRepository;
    @Autowired private PasswordEncoder passwordEncoder;
    @Autowired private Cloudinary      cloudinary;

    // ══════════════════════════════════════════════════════════════════════════
    // PROFILE — VIEW
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Shows the currently logged-in user's profile page.
     * Always reads the freshest data from the DB (not just session).
     */
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        UserEntity sessionUser = requireLogin(session);
        if (sessionUser == null) return "redirect:/login";

        // Refresh from DB to show latest values (e.g. after concurrent update)
        UserEntity user = userRepository.findById(sessionUser.getUserId())
                .orElse(sessionUser);

        model.addAttribute("user",       user);
        model.addAttribute("activeMenu", "profile");
        model.addAttribute("pageTitle",  "My Profile");

        return "pages/user/Profile";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // PROFILE — UPDATE (personal info + optional photo)
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Saves profile changes:
     * firstName, lastName, email, contactNum, birthYear, gender
     * + optional new profile picture (uploaded to Cloudinary).
     */
    @PostMapping("/profile/update")
    public String updateProfile(UserEntity updatedUser,
                                @RequestParam(value = "profilePic", required = false)
                                        MultipartFile profilePic,
                                HttpSession session,
                                RedirectAttributes ra) {

        UserEntity sessionUser = requireLogin(session);
        if (sessionUser == null) return "redirect:/login";

        UserEntity user = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (user == null) {
            session.invalidate();
            return "redirect:/login";
        }

        // ── Apply field updates ────────────────────────────────────────────────
        if (updatedUser.getFirstName() != null) user.setFirstName(updatedUser.getFirstName().trim());
        if (updatedUser.getLastName()  != null) user.setLastName(updatedUser.getLastName().trim());
        if (updatedUser.getEmail()     != null) user.setEmail(updatedUser.getEmail().trim());
        if (updatedUser.getContactNum()!= null) user.setContactNum(updatedUser.getContactNum().trim());
        if (updatedUser.getBirthYear() != null) user.setBirthYear(updatedUser.getBirthYear());
        if (updatedUser.getGender()    != null) user.setGender(updatedUser.getGender());

        // ── Optional photo upload ──────────────────────────────────────────────
        if (profilePic != null && !profilePic.isEmpty()) {
            try {
                Map<?, ?> result = cloudinary.uploader().upload(profilePic.getBytes(), null);
                Object url = result.get("secure_url");
                if (url != null) user.setProfilePicURL(url.toString());
            } catch (IOException ex) {
                ra.addFlashAttribute("error", "Profile picture upload failed. Other changes were saved.");
            }
        }

        userRepository.save(user);
        session.setAttribute("user", user);  // Refresh session so header reflects changes immediately

        ra.addFlashAttribute("success", "Profile updated successfully.");
        return "redirect:/profile";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // PROFILE — CHANGE PASSWORD
    // ══════════════════════════════════════════════════════════════════════════

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session,
                                 RedirectAttributes ra) {

        UserEntity sessionUser = requireLogin(session);
        if (sessionUser == null) return "redirect:/login";

        UserEntity user = userRepository.findById(sessionUser.getUserId()).orElse(null);
        if (user == null) return "redirect:/login";

        // ── Verify old password ────────────────────────────────────────────────
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            ra.addFlashAttribute("error", "Current password is incorrect.");
            return "redirect:/profile";
        }

        // ── Minimum length guard ───────────────────────────────────────────────
        if (newPassword == null || newPassword.length() < 8) {
            ra.addFlashAttribute("error", "New password must be at least 8 characters.");
            return "redirect:/profile";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        session.setAttribute("user", user);

        ra.addFlashAttribute("success", "Password changed successfully.");
        return "redirect:/profile";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // PROFILE — SELF DEACTIVATE
    // ══════════════════════════════════════════════════════════════════════════

    @PostMapping("/profile/deactivate")
    public String deactivateProfile(HttpSession session, RedirectAttributes ra) {
        UserEntity sessionUser = requireLogin(session);
        if (sessionUser == null) return "redirect:/login";

        userRepository.findById(sessionUser.getUserId()).ifPresent(user -> {
            user.setActive(false);
            userRepository.save(user);
        });

        session.invalidate();
        ra.addFlashAttribute("success", "Your account has been deactivated.");
        return "redirect:/login";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // PROFILE — SELF DELETE (permanent)
    // ══════════════════════════════════════════════════════════════════════════

    @PostMapping("/profile/delete")
    public String deleteProfile(HttpSession session, RedirectAttributes ra) {
        UserEntity sessionUser = requireLogin(session);
        if (sessionUser == null) return "redirect:/login";

        userRepository.deleteById(sessionUser.getUserId());
        session.invalidate();
        ra.addFlashAttribute("success", "Your account has been permanently deleted.");
        return "redirect:/login";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // SETTINGS PAGE
    // ══════════════════════════════════════════════════════════════════════════

    @GetMapping("/settings")
    public String settings(HttpSession session, Model model) {
        if (requireLogin(session) == null) return "redirect:/login";
        model.addAttribute("activeMenu", "settings");
        model.addAttribute("pageTitle",  "Settings");
        return "pages/user/Setting";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // ADMIN — LIST ALL USERS
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Admin-only: shows all platform users.
     *
     * Data provided to JSP:
     * - userList → List<UserEntity>
     */
    @GetMapping("/listuser")
    public String listUsers(
            @RequestParam(defaultValue = "0")         int    page,
            @RequestParam(defaultValue = "10")        int    size,
            @RequestParam(defaultValue = "")          String keyword,
            @RequestParam(defaultValue = "firstName") String sortBy,
            @RequestParam(defaultValue = "asc")       String direction,
            HttpSession session, Model model) {
        UserEntity user = requireLogin(session);
        if (user == null) return "redirect:/login";
        if (!"Admin".equals(user.getRole())) return "redirect:/customer-dashboard";

        Sort sort = "desc".equalsIgnoreCase(direction)
                ? Sort.by(sortBy).descending()
                : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);

        Page<UserEntity> userPage;
        if (keyword != null && !keyword.isBlank()) {
            userPage = userRepository.findByFirstNameContainingIgnoreCaseOrLastNameContainingIgnoreCaseOrEmailContainingIgnoreCase(
                    keyword, keyword, keyword, pageable);
        } else {
            userPage = userRepository.findAll(pageable);
        }

        model.addAttribute("userPage",   userPage);
        model.addAttribute("keyword",    keyword);
        model.addAttribute("sortBy",     sortBy);
        model.addAttribute("direction",  direction);
        model.addAttribute("activeMenu", "users");
        model.addAttribute("pageTitle",  "Users");

        return "pages/user/ListUser";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // ADMIN — VIEW SINGLE USER
    // ══════════════════════════════════════════════════════════════════════════

    @GetMapping("/viewuser")
    public String viewUser(@RequestParam Integer userId,
                           HttpSession session,
                           Model model) {

        UserEntity requestingUser = requireLogin(session);
        if (requestingUser == null) return "redirect:/login";
        if (!"Admin".equals(requestingUser.getRole())) return "redirect:/customer-dashboard";

        UserEntity targetUser = userRepository.findById(userId).orElse(null);
        if (targetUser == null) return "redirect:/listuser";

        model.addAttribute("user", targetUser);
        return "pages/user/ViewUser";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // ADMIN — HARD DELETE USER
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Permanently deletes a user.
     * Admin cannot delete themselves through this route.
     */
    @GetMapping("/deleteuser")
    public String deleteUser(@RequestParam Integer userId,
                             HttpSession session,
                             RedirectAttributes ra) {

        UserEntity admin = requireLogin(session);
        if (admin == null) return "redirect:/login";
        if (!"Admin".equals(admin.getRole())) return "redirect:/customer-dashboard";

        // Prevent self-deletion via this admin route
        if (admin.getUserId().equals(userId)) {
            ra.addFlashAttribute("error", "You cannot delete your own admin account from this page.");
            return "redirect:/listuser";
        }

        if (!userRepository.existsById(userId)) {
            ra.addFlashAttribute("error", "User not found.");
            return "redirect:/listuser";
        }

        userRepository.deleteById(userId);
        ra.addFlashAttribute("success", "User deleted successfully.");
        return "redirect:/listuser";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // ADMIN — TOGGLE USER ACTIVE / INACTIVE
    // ══════════════════════════════════════════════════════════════════════════

    /**
     * Flips the active flag of any user.
     * Used by the toggle button in ListUser.jsp and ViewUser.jsp.
     */
    @PostMapping("/toggleuser")
    public String toggleUser(@RequestParam Integer userId,
                             HttpSession session,
                             RedirectAttributes ra) {

        UserEntity admin = requireLogin(session);
        if (admin == null) return "redirect:/login";
        if (!"Admin".equals(admin.getRole())) return "redirect:/customer-dashboard";

        Optional<UserEntity> optUser = userRepository.findById(userId);
        if (optUser.isEmpty()) {
            ra.addFlashAttribute("error", "User not found.");
            return "redirect:/listuser";
        }

        UserEntity target = optUser.get();
        target.setActive(!Boolean.TRUE.equals(target.getActive())); // Safe null flip
        userRepository.save(target);

        String statusLabel = Boolean.TRUE.equals(target.getActive()) ? "activated" : "deactivated";
        ra.addFlashAttribute("success",
                target.getFirstName() + "'s account has been " + statusLabel + ".");

        return "redirect:/listuser";
    }

    // ══════════════════════════════════════════════════════════════════════════
    // PRIVATE HELPER
    // ══════════════════════════════════════════════════════════════════════════

    private UserEntity requireLogin(HttpSession session) {
        return (UserEntity) session.getAttribute("user");
    }
}
