/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
    $(document).ready(function (){
        alert("Document Downloaded...!!!");
    });
*/

function pleaseDoLikes(pid, uid)
{
    //console.log(pid+", "+uid);
    
    var d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };
    
    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            
            if( data.trim() == 'true' )
            {
                var c = $(".like-counter").html();
                c++;
                $('.like-counter').html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR);
        }
    });
    
    
}
