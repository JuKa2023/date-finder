<script setup>
import { onMounted, ref } from 'vue'
import AccountPage from './components/Account.vue'
import LoginPage from './components/Login.vue'
import { supabase } from './supabase'

const session = ref()

onMounted(() => {
  supabase.auth.getSession().then(({ data }) => {
    session.value = data.session
  })

  supabase.auth.onAuthStateChange((_, _session) => {
    session.value = _session
  })
})
</script>

<template>
  <div class="container" style="padding: 50px 0 100px 0">
    <AccountPage v-if="session" :session="session" />
    <LoginPage v-else />
  </div>
</template>