package com.data;

public class User {
    private String gender;
    private int height, weight, age;
    private activityLevel level;
    private bodyGoal goal;


    public User(String gender, int height,
                int weight, int age,
                String level, String goal) {
        this.gender = gender;
        this.height = height;
        this.weight = weight;
        this.age = age;
        switch (level) {
            case "sed":
                this.level = activityLevel.SEDENTARY;
                break;
            case "light":
                this.level = activityLevel.LIGHTLY_ACTIVE;
                break;
            case "mod":
                this.level = activityLevel.MODERATELY_ACTIVE;
                break;
            case "very":
                this.level = activityLevel.VERY_ACTIVE;
                break;
            case "exe":
                this.level = activityLevel.EXTREMELY_ACTIVE;
                break;
        }
        switch (goal) {
            case "maj_loss":
                this.goal = bodyGoal.MAJOR_WEIGHT_LOSS;
                break;
            case "min_loss":
                this.goal = bodyGoal.MINOR_WEIGHT_LOSS;
                break;
            case "maintain":
                this.goal = bodyGoal.MAINTAIN;
                break;
            case "min_gain":
                this.goal = bodyGoal.MINOR_WEIGHT_GAIN;
                break;
            case "maj_gain":
                this.goal = bodyGoal.MAJOR_WEIGHT_GAIN;
                break;
            
        }
    }

    public int getAge() {
        return age;
    }

    public int getHeight() {
        return height;
    }

    public int getWeight() {
        return weight;
    }
    public String getGender(){
        return gender;
    }

    public bodyGoal getGoal(){
        return goal;

    }
    public activityLevel getLevel(){
        return level;

    }

    private int calculate_BMR(){
        int BMR;
        // User is male
        if (gender == "male")
            BMR = (int) (10 * (weight / 2.2) + 6.25 * (height * 2.54) - 5 * age + 5); 
        // User is female
        else
            BMR = (int) (10 * (weight / 2.2) + 6.25 * (height * 2.54) - 5 * age - 161);

        return BMR;

    }

    private int calculate_TDEE(){
        return (int) (calculate_BMR() * level.get_movement_expenditure());
    }

    public int calculate_calorie_need(){
        return calculate_TDEE() - goal.get_cal();

    }


}