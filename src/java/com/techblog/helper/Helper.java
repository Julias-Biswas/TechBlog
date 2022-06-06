/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

/**
 *
 * @author julia
 */
public class Helper 
{
    public static boolean deleteFile(String path)
    {
        boolean status = false;
        
        try
        {
            File file = new File(path);
            
            status = file.delete();
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
    
    public static boolean saveFile(InputStream is, String path)
    {
        boolean status = false;
        
        try
        {
            byte[] b = new byte[is.available()];
            
            is.read(b);
            
            FileOutputStream fout = new FileOutputStream(path);
            
            fout.write(b);
            fout.flush();
            fout.close();
            
            status = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
}
