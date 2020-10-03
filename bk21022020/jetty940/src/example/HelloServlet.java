/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package example;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class HelloServlet extends HttpServlet
{
    final String greeting;

    public HelloServlet()
    {
        this("Hello");
    }

    public HelloServlet( String greeting )
    {
        this.greeting = greeting;
    }

    @Override
    protected void doGet( HttpServletRequest request,
                          HttpServletResponse response ) throws ServletException,
                                                        IOException
    {
        System.out.println("WWWWWWWWWWWWWWWWWWWw");
        response.setContentType("text/html");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().println(
                "<h1>" + greeting + " from HelloServlet</h1>");
    }
}