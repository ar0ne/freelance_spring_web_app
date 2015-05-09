 
;$(function () {
    $("#update_profile__button").click(function (e) {
        e.preventDefault();
        $("#user_profile, #update_profile_form").toggle("slow");
    });
    
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
    
    $(".delete_vacancy__button").click(function(e) {
        e.preventDefault();
        var parent_tr  = $(this).parent().parent();
        var id  = parent_tr.find("td.vacancy_id").text();
        var url = $(this).attr("href");
        
        $.ajax({
            method: "POST",
            url: url,
            data: {
                vacancyId: id
            },
            success: function(msg) {
                console.log("Deleted!");
                console.log();
                parent_tr.remove();
            },
            error: function(msg){
                console.log("Error: " + msg);
            }
        });
    });
    
    $(".accept_job_request__button").click(function(e){
        e.preventDefault();
        
        var parent_tr = $(this).parent().parent();
        var requestId = parent_tr.find("td.request_id").text();
        var url = $(this).attr("href");
        var vacancyId = parent_tr.parent().parent().parent().find("tr").find("td.vacancy_id").text();
        
        $.ajax({
            method: "POST",
            url: url,
            data: {
                requestId:  requestId,
                vacancyId:  vacancyId
            },
            success: function (msg) {
                console.log("Accepted!");
                console.log();
                //parent_tr.remove();
            },
            error: function (msg) {
                console.log("Error: " + msg);
            }
        });
        
    });
    
});   





