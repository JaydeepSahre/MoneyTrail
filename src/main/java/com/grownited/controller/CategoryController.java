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
	
	@GetMapping("/addcategory")
	public String AddCategory() {
		return "AddCategory";
	}
	
	@PostMapping("/savecategory")
	public String saveCategory(CategoryEntity categoryEntity) {
		categoryRepository.save(categoryEntity);
		return "redirect:/listcategory";
	}
	
	@GetMapping("/listcategory")
	public String listCategory(Model model) {
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList", categoryList);
		return "ListCategory";
	}
	
	@GetMapping("/addsubcategory")
	public String AddSubCategory(Model model) {
		List<CategoryEntity> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		return "AddSubCategory";
	}
	
	@PostMapping("/savesubcategory")
	public String saveSubCategory(SubCategoryEntity subCategoryEntity) {
		subCategoryRepository.save(subCategoryEntity);
		return "redirect:/listsubcategory";
	}
	
	@GetMapping("/listsubcategory")
	public String listSubCategory(Model model) {
		List<SubCategoryEntity> subCategoryList = subCategoryRepository.findAll();
		List<CategoryEntity> categories = categoryRepository.findAll();
		model.addAttribute("subCategoryList", subCategoryList);
		model.addAttribute("categories", categories);
		return "ListSubCategory";
	}
}