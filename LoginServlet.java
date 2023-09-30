package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.data.Meal;
import com.data.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;



 
@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    

    @Override
    public void init() throws ServletException {
        // TODO Auto-generated method stub
        System.out.println("my servlet init() call");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        
        try {
            int count = 0;
            int age = Integer.parseInt(request.getParameter("age"));
            int height = Integer.parseInt(request.getParameter("height"));
            int weight = Integer.parseInt(request.getParameter("weight"));
            int num_meals = Integer.parseInt(request.getParameter("num_meals"));
            String sql_call = "";
            String gender = request.getParameter("gender");
            String levels = request.getParameter("levels");
            String goal = request.getParameter("goal");
            String diet = request.getParameter("diet");
            double carb_percent = 0.0;
            double fat_percent = 0.0;
            double protein_percent = 0.0;
            if (diet.equals("default") ){
                carb_percent = .40;
                fat_percent = .30;
                protein_percent = .30;

            }
            else if(diet.equals("keto")){
                carb_percent = .10;
                fat_percent = .70;
                protein_percent = .20;

            }
            else if(diet.equals("low-fat")){
                carb_percent = .60;
                fat_percent = .20;
                protein_percent = .20;

            }
            else if(diet.equals("low-carb")){
                carb_percent = .20;
                fat_percent = .55;
                protein_percent = .25;

            }
            else{
                carb_percent = .40;
                fat_percent = .10;
                protein_percent = .50;

            }
            User user = new User(gender, height, weight, age, levels, goal);
            //User user = new User("male", 80, 123, 22, "light", "maintain");
            int calories = user.calculate_calorie_need();
            List<Meal> meals = new ArrayList<Meal>();
            
 


            Connection con = DatabaseConnection.initializeDatabase();
            

            CallableStatement cs;

        
            // Call a SQL procedure based on number of meals
            if (num_meals == 3)
                sql_call = "{CALL 3_meals(?,?,?,?)}";
            else if (num_meals == 4)
                sql_call = "{CALL 4_meals(?,?,?,?)}";
            else
                sql_call = "{CALL 5_meals(?,?,?,?)}";
            cs = con.prepareCall(sql_call);
            
            cs.setInt(1,calories);
            cs.setDouble(2, carb_percent);
            cs.setDouble(3, protein_percent );
            cs.setDouble(4, fat_percent);
          
            /*
            * Create a meal plan for each day of the week
            */
            while (count != 7){

            
                cs.execute();

                /*
                * List of all the calculated meals
                */
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from result");

        
                
                
                /*
                * Delete the result table
                */
                Statement st2 = con.createStatement();
                st2.executeUpdate("Drop table result");

                /*
                * Cheeck to see if the query result is empty
                * If yes, exit out the loop and inform the user
                */
                if (rs.next() == false){
                    System.out.println("ResultSet in empty in Java");
                    break;

                }
                else{
                    do{
                        Meal meal = new Meal();
                    
                        meal.setName(rs.getString("rec_name"));
                        meal.setCal(rs.getInt("calories") );
                        meal.setCarbs( rs.getInt("carbs") );
                        meal.setProtein(rs.getInt("protein"));
                        meal.setFat(rs.getInt("fat"));
                        meal.setTotal_servings(rs.getInt("total_servings"));
                        meal.setMeal_servings(rs.getInt("meal_servings"));
                        meal.setDirections(rs.getString("directions"));
                        meal.setIngredients(rs.getString("ingredients"));
                        meal.setImg(rs.getString("img"));

                        meals.add(meal);

                    } while (rs.next());
                }

                

          
    
                // while(rs.next()){
                //     Meal meal = new Meal();
                    
                //     meal.setName(rs.getString("rec_name"));
                //     meal.setCal(rs.getInt("calories") );
                //     meal.setCarbs( rs.getInt("carbs") );
                //     meal.setProtein(rs.getInt("protein"));
                //     meal.setFat(rs.getInt("fat"));
                //     meal.setTotal_servings(rs.getInt("total_servings"));
                //     meal.setMeal_servings(rs.getInt("meal_servings"));
                //     meal.setDirections(rs.getString("directions"));
                //     meal.setIngredients(rs.getString("ingredients"));
                //     meal.setImg(rs.getString("img"));

                //     meals.add(meal);
                // }


                count += 1;
            }

            /*
            * The query is empty
            * Send a message to user to try again
            */
            if (count != 7){
                PrintWriter writer = response.getWriter();
         
                // build HTML code
                String htmlRespone = "<html>";
                htmlRespone += "<div style = ' position: absolute;\n" + //
                        "    position: absolute;\n" + //
                        "    top: 50%;\n" + //
                        "    left: 50%;\n" + //
                        "    transform: translate(-50%, -50%);\n" + //
                        "    text-align: center;'> ";
                htmlRespone += "<h2> Unable to build a meal plan based on preferences </h2>";  
                htmlRespone += "<h2> Lowering the number of meals will give us a better chance at building your meal plan </h2>";  
                htmlRespone += "<h2> Press Back button to make necessary changes </h2>";   
                htmlRespone += "<button onclick='history.back()'> Back </button>";   
                htmlRespone += "</div> ";
                // htmlRespone += "<h2> Levels: " + levels + " </h2>"; 
                // htmlRespone += "<h2> Diet: " + diet+ " </h2>"; 
                // htmlRespone += "<h2> Carbs: " + carb_percent + " </h2>";     
                // htmlRespone += "<h2> Protein: " + protein_percent + " </h2>";  
                // htmlRespone += "<h2> Fat: " + fat_percent + " </h2>";  
                // htmlRespone += "<h2> Calories: " + user.calculate_calorie_need() + " </h2>"; 
                // htmlRespone += "</html>";

                // return response
                writer.println(htmlRespone);

            }
            /*
            * The query succesfully returns a list of meals
            * Output meals to jsp page
            */
            else{
                request.setAttribute("meals", meals);
                request.getRequestDispatcher("meal.jsp").forward(request, response);

            }

            

            con.close();


            
            
            
            
        } catch (ClassNotFoundException e) {
            PrintWriter writer = response.getWriter();
            String htmlRespone = "<html>";
            htmlRespone += "<h2>Your username is: class not found<br/>";      
            // htmlRespone += "Your password is: " + password + "</h2>";    
            htmlRespone += "</html>";
        
        // return response
        writer.println(htmlRespone);
            e.printStackTrace();
        } catch (SQLException e) {
            PrintWriter writer = response.getWriter();
            String htmlRespone = "<html>";
            htmlRespone += "<h2>Your username is: sql exception <br/>";      
            // htmlRespone += "Your password is: " + password + "</h2>";    
            htmlRespone += "</html>";
            
            // return response
            writer.println(htmlRespone);
            e.printStackTrace();
        }
 
    }
 
  
         
    
 
}