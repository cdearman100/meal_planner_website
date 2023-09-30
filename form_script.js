

const form = document.querySelector("form");
const select1 = document.getElementById("act_level");
const select2 = document.getElementById("b_goal");
const age = document.getElementById('age');
const height = document.getElementById('height');
const weight = document.getElementById('weight');
const gender = document.getElementsByName('gender');
const level = document.getElementsByName('levels');
const goal = document.getElementsByName('goal');






let counter = 0;

/**
 * Define a function to navigate betweens form steps.
 * It accepts one parameter. That is - step number.
 */
 const navigateToFormStep = (stepNumber) => {
    /**
     * Hide all form steps.
     */
    document.querySelectorAll(".form-step").forEach((formStepElement) => {
        formStepElement.classList.add("no-display");
    });
    /**
     * Mark all form steps as unfinished.
     */
    document.querySelectorAll(".form-stepper-list").forEach((formStepHeader) => {
        formStepHeader.classList.add("form-stepper-unfinished");
        formStepHeader.classList.remove("form-stepper-active", "form-stepper-completed");
    });
    /**
     * Show the current form step (as passed to the function).
     */
    document.querySelector("#step-" + stepNumber).classList.remove("no-display");
    /**
     * Select the form step circle (progress bar).
     */
    const formStepCircle = document.querySelector('li[step="' + stepNumber + '"]');
    /**
     * Mark the current form step as active.
     */
    formStepCircle.classList.remove("form-stepper-unfinished", "form-stepper-completed");
    formStepCircle.classList.add("form-stepper-active");
    /**
     * Loop through each form step circles.
     * This loop will continue up to the current step number.
     * Example: If the current step is 3,
     * then the loop will perform operations for step 1 and 2.
     */
    for (let index = 0; index < stepNumber; index++) {
        /**
         * Select the form step circle (progress bar).
         */
        const formStepCircle = document.querySelector('li[step="' + index + '"]');
        /**
         * Check if the element exist. If yes, then proceed.
         */
        if (formStepCircle) {
            /**
             * Mark the form step as completed.
             */
            formStepCircle.classList.remove("form-stepper-unfinished", "form-stepper-active");
            formStepCircle.classList.add("form-stepper-completed");
        }
    }
};
/**
 * Select all form navigation buttons, and loop through them.
 */
document.querySelectorAll(".btn-navigate-form-step").forEach((formNavigationBtn) => {
    /**
     * Add a click event listener to the button.
     */
    formNavigationBtn.addEventListener("click", () => {
        
        
        /**
         * Check for errors in 1st page of form
         */      
        if (age.value === '' || age.value < 13 || age.value > 80 || isNaN(age.value) == true){
            document.querySelector(".age-error").innerHTML = "Age must be between 13-80.";
            document.querySelector(".age-error").style.color= "red";
            document.querySelector(".age-error").style.display = "block";
            document.querySelector(".height-error").style.display = "none";
            document.querySelector(".weight-error").style.display = "none";
            document.querySelector(".gender-error").style.display = "none";
        }
        else if (height.value === '' || height.value < 48 || height.value > 96 || isNaN(height.value) == true){
            document.querySelector(".height-error").innerHTML = "Height must be between 48in and 96in.";
            document.querySelector(".height-error").style.color= "red";
            document.querySelector(".height-error").style.display = "block";
            document.querySelector(".age-error").style.display = "none";
            document.querySelector(".weight-error").style.display = "none";
            document.querySelector(".gender-error").style.display = "none";
        
        }
        else if (weight.value === '' || isNaN(weight.value) == true){
            document.querySelector(".weight-error").innerHTML = "Please eneter your weight.";
            document.querySelector(".weight-error").style.color= "red";
            document.querySelector(".weight-error").style.display = "block";
            document.querySelector(".age-error").style.display = "none";
            document.querySelector(".height-error").style.display = "none";
            document.querySelector(".gender-error").style.display = "none";
        
        }
        else if (!(gender[0].checked || gender[1].checked)){
            document.querySelector(".gender-error").innerHTML = "Please check your gender.";
            document.querySelector(".gender-error").style.color= "red";
            document.querySelector(".gender-error").style.display = "block";
            document.querySelector(".age-error").style.display = "none";
            document.querySelector(".height-error").style.display = "none";
            document.querySelector(".weight-error").style.display = "none";

            

        }
        // else if (stepNumber == 2 && !(level[0].checked || level[1].checked 
        //     || level[2] || level[3]) ){
        //     document.querySelector(".level-error").innerHTML = "Please check your activity level.";
        //     document.querySelector(".level-error").style.color= "red";

        // }
        else{
            /**
             * Remove Error Messages
             */
            document.querySelector(".gender-error").style.display = "block";
            document.querySelector(".age-error").style.display = "none";
            document.querySelector(".height-error").style.display = "none";
            document.querySelector(".weight-error").style.display = "none";

        
            /**
             * Get the value of the step.
             */
            const stepNumber = parseInt(formNavigationBtn.getAttribute("step_number"));
            /**
             * Call the function to navigate to the target form step.
             */
            navigateToFormStep(stepNumber);
        }
    });
});

/**
* Create a pie chart with 3 labels
*/
const ctx = document.getElementById('mychart').getContext('2d');
const data = {
    datasets: [{
        data: [50, 20, 30]
    }],

    // These labels appear in the legend and in the tooltips when hovering different arcs
    labels: [
        'CARB',
        'FAT',
        'PROTEIN'
    ],
    options: {
        maintainAspectRatio: false,
    }
};

/**
* Give the pie chart a variable
*/
let mychart = new Chart(ctx, {
    type: 'pie', 
    data,
    plugins: [ChartDataLabels],
    borderWidth:1
});

/**
*  Update pie chart values to resemble "maintain" macros
*/
function updateChart(){
    var diet = document.getElementById("diet").value;


    if (diet == "default"){
        mychart.data.datasets[0].data[0] = 40;
        mychart.data.datasets[0].data[1] = 30
        mychart.data.datasets[0].data[2] = 30;

    }
    else if (diet == "keto"){
        mychart.data.datasets[0].data[0] = 10;
        mychart.data.datasets[0].data[1] = 70;
        mychart.data.datasets[0].data[2] = 20;

    }
    else if (diet == "low-fat"){
        mychart.data.datasets[0].data[0] = 60;
        mychart.data.datasets[0].data[1] = 20;
        mychart.data.datasets[0].data[2] = 20;

    }
    else if (diet == "low-carb"){
        mychart.data.datasets[0].data[0] = 20;
        mychart.data.datasets[0].data[1] = 55;
        mychart.data.datasets[0].data[2] = 25;

    }
    else{
        mychart.data.datasets[0].data[0] = 40;
        mychart.data.datasets[0].data[1] = 10;
        mychart.data.datasets[0].data[2] = 50;

    }

    

    
    mychart.update();
}


