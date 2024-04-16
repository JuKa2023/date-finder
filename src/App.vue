<script setup>
import { onMounted, ref } from 'vue'
import AccountPage from './components/Account.vue'
import { supabase } from './supabase'
import LandingPage from './components/LandingPage.vue';

const session = ref()


const name = ref('')

onMounted(() => {
  supabase.auth.getSession().then(({ data }) => {
    session.value = data.session

    // get user data
    if (data?.session) {
      console.log(data.session.user.id)

      // check local storage
      const user = JSON.parse(localStorage.getItem('user'))
      if (user) {
        name.value = user.username
      } else {
        supabase
          .from('profiles')
          .select('*')
          .eq('id', data.session.user.id)
          .single()
          .then(({ data, error }) => {
            if (error) console.error('error', error)
            console.log('data', data)
            name.value = data?.username
            localStorage.setItem('user', JSON.stringify(data))
          })
        }
    }

  })

  supabase.auth.onAuthStateChange((_, _session) => {
    session.value = _session
  })
})
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
              <a href="/">Logout</a>
              <!-- Add additional links here if needed -->
            </div>
          </li>
        </ul>
      </nav>
    </div>
</header>

<main>
<router-view>
  <LandingPage />
  <AccountPage />
</router-view></main>
</template>


<style scoped>
/* Header component styling here */
/* Header component styling */


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
