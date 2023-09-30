<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.data.Meal"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.sql" prefix="sql" %>


<% List<Meal> meals = (ArrayList<Meal>)request.getAttribute("meals");
  int num_meals = meals.size();
  int count = 0;
  String serving_size = "";
  String meal_servings = "";
  String total_servings = "";
 
%>


<!DOCTYPE html>
<html lang="en">
    
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Meal Planner</title>
        <!-- <link rel = "stylesheet" type="text/css" href="meal_style.css" /> -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.1.1/chart.umd.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
        <script src="https://unpkg.com/chart.js-plugin-labels-dv/dist/chartjs-plugin-labels.min.js"></script>
        <!-- <script defer src="meal_script.js"></script> -->

        <script type="text/javascript">
            

            function openPopUp(count){
                
                
                popUp.style.display = 'block';
                overlay.style.display = 'block';

                
                
                var popUp_dir = document.getElementsByClassName("popUp_dir")[count];
                var popUp_ingredients = document.getElementsByClassName("popUp_ingredients")[count];
                var popUp_img = document.getElementsByClassName("popUp_img")[count];
                var popUp_m_serv = document.getElementsByClassName("popUp_m_serv")[count];
                var popUp_t_serv = document.getElementsByClassName("popUp_t_serv")[count];

                var directions = document.getElementById("directions");
                var ingredients= document.getElementById("ingredients");
                var image = document.getElementById("image");
                var servings = document.getElementById("servings");

                image.src = popUp_img.src;
                directions.innerHTML = '';
                directions.innerHTML += "<h3>Directions</h3>";
                directions.innerHTML += popUp_dir.innerHTML;
                ingredients.innerHTML = '';
                ingredients.innerHTML += "<h3>Ingredients</h3>";
                ingredients.innerHTML += popUp_ingredients.innerHTML;
                servings.innerHTML = '';
                servings.innerHTML += "<h3>Servings</h3>";
                servings.innerHTML += popUp_m_serv.innerHTML;
                servings.innerHTML += "<br>";
                servings.innerHTML += popUp_t_serv.innerHTML;
                
                // directions.innerHTML = '<h3> Directions </h3> <p>' + meal_dir.innerHTML + '</p>';

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
        </script>


        <style>
            
            body{
                height: 100%;
                margin: 0;
                /* margin-top: 5%;
                margin-left: 8%;
                margin-right: 8%; */
                background-color: white;

            
            
            }
            .container{
                height: 100%;
                margin-top: 5%;
                margin-left: 8%;
                margin-right: 8%;
                background-color: white;

            
            
            }
            .header{
                background-color: white;
                height: 11cqh;
                margin: 0;
                box-shadow: 0 8px 8px -4px lightgray;
                display: flex;
                
                align-items: center;
            
            }
            .header img {
                /* float: left; */
                width: 180px;
                height: 11cqh;
                color: white;
                object-fit: contain;  
            }
            
            .header h1 {
                align-items: center;
                /* position: relative; */
                /* top: 18px;
                left: 10px; */
                
            }
            
            /* Pop up screen for when user clicks meal title */
            #popUp {
                position: absolute;
                background-color: #fff;
                padding: 6%;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 50%;
                height: 50%;
                border-radius: 30px;
                z-index: 15;
                overflow-y:auto;
                display: none;
            }
            #overlay { 
                opacity:    0.5; 
                background: #000; 
                width:      100%;
                height:     100%; 
                z-index:    10;
                top:        0; 
                left:       0; 
                position:   fixed; 
                display: none;
            }

            /* Style the tab */
            .tab {
                overflow: hidden;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
            }
            
            /* Style the buttons inside the tab */
            .tab button {
                background-color: inherit;
                float: left;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 14px 16px;
                transition: 0.3s;
                font-size: 17px;
            }
            
            /* Change background color of buttons on hover */
            .tab button:hover {
                background-color: #ddd;
            }
            
            /* Create an active/current tablink class */
            .tab button.active {
                background-color: #ccc;
            }




            
            
            
            .grid {
                display: grid;
                grid-template-columns: 25vw 25vw 25vw 25vw;
                grid-template-rows: 5% fit-content(50%);
                grid-gap: 1em 1em;
                grid-auto-flow: row dense;
                display: flex;
                margin-bottom: 2%;
                
                
            }
            
            .item {
                background-color: white;
                border-radius: 0.25em;
                box-shadow: 0 3px 10px rgb(0 0 0 / 0.2);
                display: flex;
                flex-direction: column;
                flex: 1;

            

            }
            
            .item img{
                height: 100%;
                width: 100%;
                object-fit: cover;

            
            }

            .meal_img{
                display:inline-block;
                position:relative;
            }

            .meal_img div{
                position: absolute;
                bottom:0;
                right:0;
                
            }





            .meal_desc{
                min-height: 110px;
                font-size: large;
                
                
                background-color: white;
                font-weight: bold;
                display: flex;
                flex-direction: column;
                
            }

            .label{
                margin-left: 3%; 
                padding: 2px; 
                color: white; 
                font-size: small; 
                width: fit-content; 
                text-align: left; 
                border-radius: 5px; 
            }
            .breakfast{
                font-size: 1cqw;
                background-color: #06aed5; 
            }
            .lunch{
                font-size: 1cqw;
                background-color: #187570;
            }
            .dinner{
                font-size: 1cqw;
                background-color:#aa673f;
            }
            .snack{
                font-size: 1cqw;
                background-color: #dd1c1a;
            }

            .grid_btn{
                display: none;

                
                color:white;

                background-color: orange;
            


                width: fit-content;
                font-size: 20px;
                cursor: pointer;

            }
            



            .meal_info{
                /* text-align: justify; */
                align-items: center;
            
                
                height: 28px;
                margin-top: 1%;
                background-color: white;
                display: flex;
                flex-direction: row;
            
                
            }

            .meal_info p{
                font-size:  1cqw;
                text-align: center;

                
            }

            
            .meal_info_btn{
                border: 0;
                cursor: pointer;
            }
            .meal_title {
                margin: auto;
                width: 96%;
            

            }

            .meal_title p{
                
                font-size: 1.5cqw;
            }

            .meal_title button{
    
                border: none;
                background-color: inherit;
                font-weight: bold;
                font-size: 1cqw;
                cursor: pointer;
                display: inline-block;
                text-align: center;
                
            }
            .meal_title button:hover {background: #eee;}
           

            #add_meal_button{
                color: white;
                font-size: 15cqw;
                background: transparent;
                border: none;
                cursor: pointer;
            }

            .macro_info p{
                text-align: center;
                font-size: 1cqw;
            }
            .total_cal{
                display: flexbox; 
                width:100%; 
                max-width:8cqw; 
                position: absolute; 
                top: 2cqh; 
                left: 0cqw;
                font-weight: bold;
            }
            .total_fat{
                display: flexbox; 
                width:100%; 
                max-width:8cqw; 
                position: absolute; 
                top: 2cqh; 
                right: 0cqw;
                font-weight: bold;
            }

            .total_protein{
                display: flexbox; 
                width:100%; 
                max-width:8cqw; 
                position: absolute; 
                bottom: 2cqh; 
                right: 0cqw;
                font-weight: bold;
            }
            .total_carb{
                display: flexbox; 
                width:100%; 
                max-width:8cqw; 
                position: absolute; 
                bottom: 2cqh; 
                left: 0cqw;
                font-weight: bold;
            }

            .cal{
                color:#06aed5;
            }
            .fat{
                color: #187570;
            }
            .carb{
                color: #6f1a07;
            }
            .protein{
                color: #dd1c1a;
            }
                  
            .heading {
                padding: 1px;
                padding-left: 5px;
                height: 150%;
            }
            
  

        </style>
        
        
    </head>

    <body> 

        <sql:setDataSource var = "snapshot" driver = "com.mysql.cj.jdbc.Driver"
         url = "jdbc:mysql:// localhost:3306/"
         user = "root"  password = "root"/>
 
        <sql:query dataSource = "${snapshot}" var = "result">
            SELECT * from Meal_Plan.breakfast limit 1;
        </sql:query>

        <div class="header">
            <img src="https://dynamic.brandcrowd.com/asset/logo/d5787595-2257-44db-a8b3-29880bf587f6/logo-search-grid-1x?logoTemplateVersion=1&v=637653947610000000&text=Calorie+Crafted"/>
            
        </div>


        <div class="container">

        
        
            <h1>Meal Plan</h1>

            <h2>Day 1</h2>




            
            <div id="popUp">
                <div style="width: 100%; height: 100%;
                position:relative;">
                    <img  id="image" style="position: absolute;  height: 100%; width: 100%; object-fit:contain;" src='https://www.bodybuilding.com/images/2019/metaburn90/mb90-poached-chicken-header-960x540.jpg'>

                </div>

                <div class="tab">
                    <button class="tablinks" onclick="openTab(event, 'directions')">Directions</button>
                    <button class="tablinks" onclick="openTab(event, 'ingredients')">Ingredients</button>
                    <button class="tablinks" onclick="openTab(event, 'servings')">Servings</button>

                </div>
                <div id="directions" class="tabcontent">
                    <h3>Directions</h3>
                </div>
                
                <div id="ingredients" class="tabcontent">
                    <h3>Ingredients</h3>
                </div>

                <div id="servings" class="tabcontent">
                    <h3>Servings</h3>
                </div>
                
                
            </div>
            <div id="overlay" onclick="closePopUp()"></div>
    

        

        
    
            <div class="grid">
                
                

                
                <% for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 1: ITEM 1-6 -->
                <% } %>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            int total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            int total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            int total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            int total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 1: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 1 ***********************-->

    <!-- *************** START ROW 2 ***********************-->
            <h2>Day 2</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 2 ***********************-->

    <!-- *************** START ROW 3 ***********************-->
            <h2>Day 3</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 3 ***********************-->

    <!-- *************** START ROW 4 ***********************-->
            <h2>Day 4</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 4 ***********************-->

    <!-- *************** START ROW 5 ***********************-->
            <h2>Day 5</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 5 ***********************-->

    <!-- *************** START ROW 6 ***********************-->
            <h2>Day 6</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
                
                    

                <div class="item" style="position: relative;">

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 6 ***********************-->

    <!-- *************** START ROW 7 ***********************-->
            <h2>Day 7</h2>
            <div class="grid">
                
                <%for (int i= 1; i <=  (num_meals / 7); i++){ %>
                    <div class="item">
                
                        <div class="meal_img">
        
                            <img src= " <%= meals.get(count).getImg() %> " >
                            <div style="display: flex;">
                                <button class="grid_btn"><i class="fa fa-refresh"></i></button>
                            
                            </div>
                        </div>
        
                        <div class="meal_desc">
                            <div class="meal_title" style="display: flex; flex-direction: column;">
                                <button onclick="openPopUp('<%= count %>')" class="btn"><%= meals.get(count).getName() %> </button>
                                <p class="popUp_dir" style="display: none;"> <%= meals.get(count).getDirections() %></p>
                                <p class="popUp_ingredients" style="display: none;"> <%= meals.get(count).getIngredients() %></p>
                                <img class="popUp_img" style="display: none;" src= " <%= meals.get(count).getImg() %> " >
                                <% meal_servings = "This recipe makes a total of " + meals.get(count).getMeal_servings() + " serving(s)"; %>
                                <% total_servings = "Your meal plan recommends you eat " + meals.get(count).getTotal_servings() + " serving(s)"; %>
                                <p class="popUp_m_serv" style="display: none;"> <%= meal_servings %></p>
                                <p class="popUp_t_serv" style="display: none;"> <%= total_servings %></p>
                                
                        </div> 
                        <% if (i == 1) { %>
                            <p class="label breakfast">breakfast</p> 
                        <% } else if (i == 2) { %>
                            <p class="label lunch">lunch</p> 
                        <% } else if (i == 3) { %>
                            <p class="label dinner">dinner</p> 
                        <% } else { %>
                            <p class="label snack">snack</p> 
                        <% } %>
                             
                        </div>
        
                        <div class="meal_info">
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCal() %></span>
                                    <span>cal</span>
                                </p>
                            </div>
                            <div style="width: 25%;">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getProtein() %></span>
                                    <span>protein</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getCarbs() %></span>
                                    <span>carbs</span>
                                </p>
                            </div>
                            <div style="width: 25%; ">
                                <p>
                                    <span style="font-weight: bolder;"><%= meals.get(count).getFat() %></span>
                                    <span>fat</span>
                                </p>
                            </div>
                        </div>             
                    </div> 
                    <%  count += 1; %>
                    <!-- END ROW 2: ITEM 1-6 -->
                <%}%>
               
                
                
                    

                <div class="item" style="position: relative;">
                    

                    
                
                    <div class="macro_info total_cal">
                        <% 
                            total_cal = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_cal +=  meals.get(count - i).getCal();
                            }
                            
                        %>

                        <p class="cal" style="font-size: 2cqw;"> <%= total_cal %>  </p>
                        <p> calories </p>
                    </div>

                    <div class="macro_info total_protein">
                        <% 
                            total_protein = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_protein +=  meals.get(count - i).getProtein();
                            }
                            
                        %>
                        <p class="protein" style="font-size: 2cqw;"> <%= total_protein %> </p>
                        <p> protein(g) </p>
                    </div>

                    <div class="macro_info total_carb">
                        <% 
                            total_carb = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_carb +=  meals.get(count - i).getCarbs();
                            }
                            
                        %>
                        <p class="carb" style="font-size: 2cqw;"> <%= total_carb %>  </p>
                        <p> carb(g) </p>
                    </div>

                    <div class="macro_info total_fat">
                        <% 
                            total_fat = 0;
                            for (int i= 1; i <=  (num_meals / 7); i++){ 
                                total_fat +=  meals.get(count - i).getFat();
                            }
                            
                        %>
                        <p class="fat" style="font-size: 2cqw;"> <%= total_fat %>  </p>
                        <p> fat(g) </p>
                    </div>


                </div>
                <!-- END ROW 2: MACRO INFO 1 -->
  
            
            </div>
    <!-- *************** END ROW 7 ***********************-->

    
        

      
        

        
        </div>
    </body>
    
</html>