package com.data;

public class Meal {
    private String name, directions, ingredients, img;
    private int cal, carbs, protein, fat, total_servings, meal_servings;


    public String getName() {
        return name;
    }

    public String getDirections() {
        return directions;
    }
    public String getIngredients() {
        return ingredients;
    }
    public String getImg() {
        return img;
    }

    public int getCal() {
        return cal;
    }
    public int getCarbs() {
        return carbs;
    }
    public int getProtein() {
        return protein;
    }
    public int getFat() {
        return fat;
    }
    public int getTotal_servings() {
        return total_servings;
    }
    public int getMeal_servings() {
        return meal_servings;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDirections(String directions) {
        this.directions = directions;
    }
    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }
    public void setImg(String img) {
        this.img = img;
    }

    public void setCal(int cal) {
        this.cal = cal;
    }
    public void setCarbs(int carbs) {
        this.carbs = carbs;
    }
    public void setProtein(int protein) {
        this.protein = protein;
    }
    public void setFat(int fat) {
        this.fat = fat;
    }
    public void setTotal_servings(int total_servings) {
        this.total_servings = total_servings;
    }
    public void setMeal_servings(int meal_servings) {
        this.meal_servings = meal_servings;
    }
    
}
