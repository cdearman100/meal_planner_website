package com.data;

public enum bodyGoal {
    MAJOR_WEIGHT_LOSS(-1000),  // Lose 2 pound(s) a week
    MINOR_WEIGHT_LOSS(-500),   // Lose 1 pound(s) a week
    MAINTAIN(0),
    MINOR_WEIGHT_GAIN(500), // Gain .5 pound(s) a week
    MAJOR_WEIGHT_GAIN(1000) // Gain 1 pound(s) a week
    ;


    private final int cal;

    bodyGoal(int cal) {
        this.cal = cal;
    }

    public int get_cal(){
        return cal;
    }
}

