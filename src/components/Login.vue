<script setup>
import { ref } from 'vue'
import {supabase} from "@/supabase";
import {useRouter} from "vue-router";

const router = useRouter()

const loading = ref(false)
const email = ref('')
const password = ref('')

async function handleLogin() {
  try {
    loading.value = true
    const {error} = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value,
    })

    if (error) {
      throw new Error(error.message)
    }

    alert('You are logged in!')
    await router.push('/dashboard')
  } catch (error) {
    if (error instanceof Error) {
      alert(error.message)
    }
  } finally {
    loading.value = false
  }
}

</script>

<template>
    <form class="row flex-center flex" @submit.prevent="handleLogin">
        <div class="col-6 form-widget">
            <h1 class="header">Supabase + Vue 3</h1>
            <div>
                <input class="inputField" required type="email" placeholder="Your email" v-model="email" />
                <input class="inputField" required type="password" placeholder="Your password" v-model="password" />
            </div>
            <div>
                <input type="submit" class="button block" :value="loading ? 'Loading' : 'Login'" :disabled="loading" />
            </div>
        </div>
    </form>
</template>