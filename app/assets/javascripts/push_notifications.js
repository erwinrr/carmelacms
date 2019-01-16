$(document).on('turbolinks:load', function(){
    $('#push_notification_user_ids').select2({
        placeholder: 'Select Customers...',
        width: "100%"
    });
    $('form#new_push_notification .push_notification_notification_type input[type=radio]').change(function(){
        display_ui(this.value)
    });
    var display_ui = function(type){
        // console.log('display_ui', type)
        $('form#new_push_notification div.possible').hide('slow');
        if(type == 'group'){
            $('div.possible.group-options').show('slow');
        }
        if(type == 'individual'){
            $('form#new_push_notification div.possible.ind-options').show('slow');    
        }
    }
    display_ui('group');
});

