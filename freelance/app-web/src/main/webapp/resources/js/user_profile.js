 
;$(function () {
    $("#update_profile__button").click(function (e) {
        e.preventDefault();
        $("#user_profile_form, #update_profile_form").toggle("slow");
    });
    
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function (e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
    
    $(".delete_vacancy__button").click(function(e) {
        e.preventDefault();
        var id  = $(this).parent().find(".vacancy_id").text();
        var url = $(this).attr("href");
        var parent_div = $(this).parent().parent().parent();
        
        $.ajax({
            method: "POST",
            url: url,
            data: {
                vacancyId: id
            },
            success: function(msg) {
                console.log("Deleted!");
                parent_div.remove();
            },
            error: function(msg){
                console.log("Error: " + msg);
            }
        });
    });
    
    $(".accept_job_request__button").click(function(e) {
        e.preventDefault();
        
        var requestId = $(this).parent().find(".request_id").text();
        var vacancyId = $(this).parent().find(".vacancy_id").text();
        var button_accept = $(this);
        var url = button_accept.attr("href");
        var div_applicant = $(this).parent().parent();
        var button_status = $("#vacancy_status__button" + vacancyId);
        
        $.ajax({
            method: "POST",
            url: url,
            data: {
                requestId:  requestId,
                vacancyId:  vacancyId
            },
            success: function (msg) {
                console.log("Accepted!");
                button_accept.remove();
                div_applicant.addClass("bg-success");
                button_status.removeClass("btn-success").addClass("btn-warning").text("Closed");
            },
            error: function (msg) {
                console.log("Error: " + msg.responseText);
            }
        });
        
    });
    
    $(".change_user_status__button").click(function (e) {
        e.preventDefault();

        var parent_tr = $(this).parent().parent();
        var userId =    parent_tr.find("td.user_id").text();
        var url =       $(this).attr("href");
        var status =    parent_tr.find(".user-status button");    

        $.ajax({
            method: "POST",
            url: url,
            data: {
                userId: userId
            },
            success: function (msg) {
                console.log("Status changed!");
                var text = status.text();
                if(text === "Banned") {
                    status.removeClass("btn-danger").addClass("btn-info").text("Active");
                } else {
                    status.removeClass("btn-info").addClass("btn-danger").text("Banned");
                }
            },
            error: function (msg) {
                console.log("Error: " + msg.responseText);
            }
        });

    });

    $(".user-status button").each(function(el) {
        if($(this).text() === "true" ) {
            $(this).removeClass("btn-danger").addClass("btn-info").text("Active");
        } else {
            $(this).removeClass("btn-info").addClass("btn-danger").text("Banned");
        }
    });

    $(".job-request-status button").each(function(el) {
        if($(this).text() === "true" ) {
            $(this).removeClass("btn-danger").addClass("btn-info").text("Accepted");
        } else {
            $(this).removeClass("btn-info").addClass("btn-danger").text("Not Accepted");
        }
    });

    $(".vacancy-status button").each(function(el) {
        if($(this).text() === "true" ) {
            $(this).removeClass("btn-success").addClass("btn-warning").text("Closed");
        } else {
            $(this).removeClass("btn-warning").addClass("btn-success").text("Open");
        }
    })


    
});   





