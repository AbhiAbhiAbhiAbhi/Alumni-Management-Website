
function load(id) {
    $('#' + id + '1').show();

    var element = document.getElementById(id + "2");
    element.scrollTop = element.scrollHeight;
    
    $('#' + id + '1').click();
};

// Set up on DOM-ready
$(function() {
    // Change this selector to find whatever your 'boxes' are
    var boxes = $(".rightarea");

    // Set up click handlers for each box
    boxes.click(function() {
        var el = $(this), // The box that was clicked
            max = 0;

        // Find the highest z-index
        boxes.each(function() {
            // Find the current z-index value
            var z = parseInt( $( this ).css( "z-index" ), 10 );
            // Keep either the current max, or the current z-index, whichever is higher
            max = Math.max( max, z );
        });

        // Set the box that was clicked to the highest z-index plus one
        el.css("z-index", max + 1 );
    });
});

function updateScroll(id)
{
    var element = document.getElementById(id);
    element.scrollTop = element.scrollHeight;
}

function validate(id)
{
    var l =document.getElementById(id).value.length;
    if(l !== 4 && l !== 0)
    {
        $('#limit').show();
    } 
    else
    {
        $('#limit').hide();
    }
};

function searchUser(name, batch, branch) {

    var uname = document.getElementById(name).value;
    var ubatch = document.getElementById(batch).value;
    var ubranch = document.getElementById(branch).value;
    var bttn = document.getElementById('searchbtn');
    
    if(bttn.innerHTML == "Search"){
        bttn.innerHTML = "Hide";
    }
    else{
        bttn.innerHTML = "Search";
    }

    const d = {
        name: uname,
        batch: ubatch,
        branch: ubranch

    };

    $.ajax({
        url: "searchUser.jsp",
        data: d,
        success: function (data, textStatus, jqXHR) {
            document.getElementById("result").innerHTML = data;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });

    $('.searchResult').toggle("show");
};


function clickSend(id1, id2)
{
    var inputText = document.getElementById(id1);
    inputText.addEventListener("keyup", function (event) {
        if (event.keyCode === 13) {
            document.getElementById(id2).click();
        }
    });
}

function sendmsg(msg, emailAdd)
{
    var text = document.getElementById(msg).value;
    document.getElementById(msg).value = '';

    const d = {
        txt: text,
        email: emailAdd
    };
    $.ajax({
        url: "chatServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}

function hideResult()
{
    $('.searchResult').hide();
}
