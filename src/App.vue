<script setup>
import { onMounted, ref } from 'vue'
import AccountPage from './components/Account.vue'
import LoginPage from './components/Login.vue'
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
            <li><a href="/"><img  class="iconheader" src="/img/logo_datefinderr.svg" alt=""></a></li>
            <li><a href="/">Date Suchen {{ name ? `(${name})` : '' }}</a></li>
            <li><a href="/"><img class="iconheader" src="/img/icon Konto.svg" alt=""></a></li>
            </ul>
        </nav>
    </div>
</header>

<main>
  <div class="container" style="padding: 50px 0 100px 0">
    <AccountPage v-if="session" :session="session" />
    <LandingPage v-else />
  </div>
</main>
</template>


<style scoped>
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
