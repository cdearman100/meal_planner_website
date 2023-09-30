/**
* Create a pie chart with 3 labels
*/
const ctx = document.getElementById('meal_chart').getContext('2d');
const data = {
    labels: ['Protein', 'Fat', 'Carbs'],
    datasets: [{
        data: [50, 20, 30], borderWidth: 1, cutout: '80%'
    }],

    
    options: {
        maintainAspectRatio: false,
    }
};

const donutChartText = {
    id: 'donutChartText',
    afterDatasetsDraw(chart, args, pluginOptions){
        const {ctx, data, chartArea: {top, bottom, left, right, width, height},
        scales: {r}} = chart;

        ctx.save();

        const xCoor = chart.getDatasetMeta(0).data[0].x;
        const yCoor = chart.getDatasetMeta(0).data[0].y;
   

        ctx.font = '80px sans-serif';
        ctx.fillStyle = '#666';
        ctx.textAlign = 'center';
        ctx.fillText('1023', xCoor, yCoor - 30);

        ctx.font = '20px sans-serif';
        ctx.fillStyle = '#666';
        ctx.textAlign = 'center';
        ctx.fillText('calories', xCoor, yCoor );
    }

}

/**
* Give the pie chart a variable
*/
let mychart = new Chart(ctx, {
    type: 'doughnut', 
    data,
    plugins: [ChartDataLabels],
    options: {
        rotation: 270,
        circumference: 180,
        segmentShowStroke : false,
	    animateScale : true,
        animation: {
            duration: 1500
        },
        plugins:{
            legend:{
                display: false
            }
        }
        
    },

    tooltip: {
        enabled: false,
    },
    plugins: [donutChartText]


});

function openPopUp(button){
    
    
    popUp.style.display = 'block';
    overlay.style.display = 'block';

    var meal_name = button.innerHtml;
    var element = document.getElementById("directions");
    element.innerHTML = '<h3> Directions </h3> <p>' + meal_name + '</p>';

}

function closePopUp(){
    
    popUp.style.display = 'none';
    overlay.style.display = 'none';
}
function openTab(evt, tab_info) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(tab_info).style.display = "block";
    evt.currentTarget.className += " active";
}