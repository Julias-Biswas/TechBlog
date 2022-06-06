/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.entities;

/**
 *
 * @author julia
 */
public class Category 
{
    private int cId;
    private String name;
    private String description;

    public Category() 
    {
        
    }

    public Category(String name, String description) 
    {
        this.name = name;
        this.description = description;
    }
    
    public Category(int cId, String name, String description) 
    {
        this.cId = cId;
        this.name = name;
        this.description = description;
    }

    public int getcId() {
        return cId;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
