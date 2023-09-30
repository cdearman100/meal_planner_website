package com.data;

public enum activityLevel {

    SEDENTARY(1.2), //Little to no exercise
    LIGHTLY_ACTIVE(1.375), //Light exercise 1-3 days/week
    MODERATELY_ACTIVE(1.55), //Moderate exercise 3-5 days/week
    VERY_ACTIVE(1.725), // Very strenuous exercise or physical job 6-7 days/week
    EXTREMELY_ACTIVE(1.9) // Intense activity daily
    ;


    private final double movement_expenditure;


    activityLevel(double movement_expenditure) {
        this.movement_expenditure= movement_expenditure;
    }

    public double get_movement_expenditure(){
        return movement_expenditure;
    }

}
