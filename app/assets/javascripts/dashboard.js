$(document).ready(function () { 

// Accès tableau de bord
$(document).bind('keydown', 't', function () {
  document.location.href="/dashboard" 
});

// Accès editer mon profil
$(document).bind('keydown', 'e', function () {
  document.location.href="/users/edit" 
});

// Accès editer mon profil
$(document).bind('keydown', 'a', function () {
  document.location.href="/friends" 
});

})
