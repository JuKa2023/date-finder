<script setup>
import {ref} from 'vue'
import {get_user} from "@/authentication";
import {supabase} from "@/supabase";
import {useRouter} from "vue-router";

const router = useRouter()

const name = ref('')
const is_logged_in = ref(false)

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
            <a href="/"><img alt="Home" class="iconheader" src="/img/logo_datefinderr.svg"></a>
            <div class="dropdown-content">
              <RouterLink to="find">Date suchen</RouterLink>

            </div>
          </li>
          <li class="dropdown">
            <a href="/"><img alt="Konto" class="iconheader" src="/img/icon_konto.svg"></a>
            <div v-if="is_logged_in" class="dropdown-content">
              <RouterLink to="/account">Mein Konto</RouterLink>
              <a @click="handle_logout">Logout</a>
            </div>
            <div v-else class="dropdown-content">
              <RouterLink to="/login">Login</RouterLink>
              <RouterLink to="/register">Registrieren</RouterLink>
            </div>
          </li>
        </ul>
      </nav>
    </div>
    <hr class="faint-line">
  </header>

  <main>
    <router-view></router-view>
  </main>

</template>

<style scoped>
header {
  padding-top: 10px;
  padding-left: 10px;
  padding-right: 10px;
  font-family: 'Poppins', sans-serif;
  background-color: #E5BABA;
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
  color: #D0A8C5;
  display: flex;
  align-items: center;
}

nav ul li a:hover {
  color: #EBCFCD;
}

.iconheader {
  height: 30px;
  padding-bottom: 10px;
}

.containerheader {
  max-width: 1000px;
  margin: 0 auto;
  width: 100%;
}

/* Dropdown Menu Styles */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #100a15;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
  width: 200px;
}

.dropdown-content a {
  color: #D0A8C5;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {
  color: #EBCFCD;
}

.dropdown:hover .dropdown-content {
  display: block;
}

nav ul li:last-child .dropdown-content {
  right: 0;
}

.faint-line {
  border: none;
  height: 1px; /* You can adjust the height to your preference */
  background-color: #211230; /* A light grey color with low opacity for faintness */
  margin-top: 20px; /* Adjust the margin to control spacing above the line */
  margin-bottom: 20px; /* Adjust the margin to control spacing below the line */
}

</style>
