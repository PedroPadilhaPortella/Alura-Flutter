importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyC7VMQaUTk-R176Hj2ButGByBywO5WwjXg",
    authDomain: "dev-meetups-3b76c.firebaseapp.com",
    projectId: "dev-meetups-3b76c",
    storageBucket: "dev-meetups-3b76c.appspot.com",
    messagingSenderId: "469341402631",
    appId: "1:469341402631:web:4dc5aa397a9c8d3bb15ca2",
    measurementId: "G-ZW09VR7X61"
});

// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});