// Your web app's Firebase configuration

import { initializeApp } from "firebase/app";

import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";
import "firebase/storage";



const firebaseConfig = {
  apiKey: "AIzaSyA8g43NDLu0dh0LC538KXbhWs4mgW_Uc0M",
  authDomain: "boat-service-hygwell.firebaseapp.com",
  projectId: "boat-service-hygwell",
  storageBucket: "boat-service-hygwell.appspot.com",
  messagingSenderId: "296230532879",
  appId: "1:296230532879:web:b35715c0d2fbc499c4f07a"
};

const app = initializeApp(firebaseConfig);

export const db = getFirestore(app);
export const storage = getStorage(app);


