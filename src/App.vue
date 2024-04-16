<script setup>
import { onMounted, ref } from 'vue'
import { get_user } from "@/authentication";
import {supabase} from "@/supabase";
import {useRouter} from "vue-router";

const router = useRouter()

const name = ref('')
const is_logged_in = ref(false)

onMounted(async () => {
  console.log('Hello World, this is the App Page')
})

supabase.auth.onAuthStateChange(async (event) => {
  if (event === 'SIGNED_OUT') {
    console.log('User signed out event detected in App.vue')
    is_logged_in.value = false
    name.value = ''
  } else if (event === 'SIGNED_IN') {
    is_logged_in.value = true
    const user = get_user();
    name.value = user.name
  }
})

async function handle_logout() {
  const {error} = await supabase.auth.signOut()
  console.log(error)

  if (!error) {
    is_logged_in.value = false
    name.value = ''
    await router.push('/login')
  }
}

</script>

<template>
<header>
    <div class="containerheader">
      <nav>
        <ul>
          <li class="dropdown">
            <a href="/"><img class="iconheader" src="/img/logo_datefinderr.svg" alt="Home"></a>
            <div class="dropdown-content">
              <a href="/">Date Suchen</a>
              <!-- Add additional links here if needed -->
            </div>
          </li>
          <li class="dropdown">
            <a href="/"><img class="iconheader" src="/img/icon_konto.svg" alt="Konto"></a>
            <div class="dropdown-content">
              <a href="/">Konto Einstellungen</a>
              <a @click="handle_logout">Logout</a>
              <!-- Add additional links here if needed -->
            </div>
          </li>
        </ul>
        <button @click="handle_logout" style="float: right;" v-if="is_logged_in">Logout</button>
      </nav>
    </div>
</header>

<main>
  <router-view></router-view>
</main>

</template>

<style scoped>
header {
  background-color: #fefafd;
  padding: 10px;
  font-family: 'Poppins', sans-serif;
}

nav ul {
  display: flex;
  justify-content: space-between;
  align-items: center;
  list-style-type: none;
  padding: 0 10px;
  margin-top: 10px;
  margin-bottom: 0px;
}

nav ul li {
  position: relative;
  margin-right: 10px;
  font-size: 18px;
}

nav ul li a {
  text-decoration: none;
  color: #000;
  display: flex;
  align-items: center;
}

nav ul li a:hover {
  color: #D77F8F;
}

.iconheader {
  height: 30px;
}

.containerheader {
  max-width: 750px;
  margin: 0 auto;
  width: 100%;
}

/* Dropdown Menu Styles */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #fefafd;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  width: 200px;
  margin-top: 10px;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
  display: block;
}

/* Specific styling for right-aligned dropdown */
nav ul li:last-child .dropdown-content {
  right: 0;  /* Aligns the dropdown to the right edge of the last <li> element */
}

</style>
