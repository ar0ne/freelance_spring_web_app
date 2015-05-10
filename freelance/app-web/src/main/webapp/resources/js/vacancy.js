;$(function(){
    var token  = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
    
    $("#add_request__button").click(function(e){
        e.preventDefault();
        $("#add_request__form").toggle("slow");
    });
    
    $("#add_request__submit").click(function(e){
        e.preventDefault();
        
        var form =      $("#add_request__form"),
            comment =   $("#add_request_comment__input").val(),
            vacancyId = form.find("input[name='vacancyId']").val(),
            request_table = $("#jobRequest_table"),
            error  =    $("#error"),
            url =       $(this).attr("href");
        
        $.ajax({
            url:    url,
            method: "POST",
            data: {
                comment: comment,
                vacancyId: vacancyId
            },
            success: function (msg) {
                var user_request = "";
                user_request += "<tr>";
                user_request +=     "<td>Date current</td>";
                user_request +=     "<td>" + comment + "</td>";
                user_request +=     "<td>???User???</td>";
                user_request += "</tr>";
                
                request_table.append(user_request);
                
                $("#add_request__button").remove();
                form.remove();
            },
            error: function (msg) {
                console.log("ERROR");
                error.text(msg.responseText);
                $("#add_request__form").toggle("slow");

            }
        });
    });
}());

