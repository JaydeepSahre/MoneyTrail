package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.SubCategoryRepository;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@Autowired
	SubCategoryRepository subCategoryRepository;
	
	// ========== CATEGORY OPERATIONS ==========
	
	// Open Add Category Page
	@GetMapping("/addcategory")
	public String openAddCategoryPage() {
		return "AddCategory";
	}
	
	// Save Category
	@PostMapping("/savecategory")
	public String saveCategory(CategoryEntity categoryEntity) {
		System.out.println("Category Name: " + categoryEntity.getCategoryName());
		categoryRepository.save(categoryEntity);
		return "Dashboard";
	}
	
	// ========== SUB CATEGORY OPERATIONS ==========
	
	// Open Add Sub Category Page
	@GetMapping("/addsubcategory")
	public String openAddSubCategoryPage(Model model) {
		// Fetch all categories from database
		List<CategoryEntity> categories = categoryRepository.findAll();
		
		// Send categories to JSP
		model.addAttribute("categories", categories);
		
		return "AddSubCategory";
	}
	
	// Save Sub Category
	@PostMapping("/savesubcategory")
	public String saveSubCategory(SubCategoryEntity subCategoryEntity) {
		
		// Print for debugging
		System.out.println("Category ID: " + subCategoryEntity.getCategoryId());
		System.out.println("Sub Category Name: " + subCategoryEntity.getSubCategoryName());
		
		// Save to database (categoryId will be stored as simple integer)
		subCategoryRepository.save(subCategoryEntity);
		
		return "Dashboard";
	}
}