<script setup>
import { onMounted, ref } from 'vue'

import Header from './components/Header.vue'

const session = ref()

</script>


<template>
    <header>
        <div class="containerheader">
            <nav>
                <ul>
                <li><a href="/"><img  class="iconheader" src="/img/logo_datefinderr.svg" alt=""></a></li>
                <li><a href="/">Date Suchen</a></li>
                <li><a href="/"><img class="iconheader" src="/img/icon Konto.svg" alt=""></a></li>
                </ul>
            </nav>
        </div>
    </header>
</template>
  
  <script>

  export default {
    name: 'Header',
  }
  </script>
  
  <style>
  /* Header component styling here */
  header {
    background-color: #fefafd;
    padding: 10px;
    margin: none;
    font-family: 'poppins', sans-serif;
  }
  nav ul {
    display: flex;
    justify-content: space-between;
    align-items: center;
    list-style-type: none;
    padding-left: 20px;
    padding-right: 20px;
  }
  
  nav ul li {
    display: inline;
    margin-right: 10px;
    font-size: 18px;
    height: 30px;
  }

  nav ul li a{
    text-decoration: none;
    color: #000;
  }

  nav ul li a:hover{
    color: #D77F8F;
  }

  .iconheader {
    height: 30px;  }
  </style>
  