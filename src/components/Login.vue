<template>
  <div class="login-container">
    <form class="login-form" @submit.prevent="handleLogin">
      <h1 class="login-header">Supabase + Vue 3</h1>
      <label for="email">Email</label>
      <input id="email" required type="email" placeholder="Enter your email" v-model="email" />

      <label for="password">Password</label>
      <input id="password" required type="password" placeholder="Enter your password" v-model="password" />

      <button type="submit" :class="{'button-loading': loading}" :disabled="loading">
        {{ loading ? 'Loading...' : 'Login' }}
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { supabase } from "@/supabase";
import { useRouter } from "vue-router";

const router = useRouter();
const loading = ref(false);
const email = ref('');
const password = ref('');

async function handleLogin() {
  try {
    loading.value = true;
    const { error } = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value,
    });

    if (error) throw new Error(error.message);

    alert('You are logged in!');
    await router.push('/dashboard');
  } catch (error) {
    if (error instanceof Error) {
      alert(error.message);
    }
  } finally {
    loading.value = false;
  }
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-form {
  padding: 2rem;
  background: white;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  width: 100%;
  max-width: 400px;
}

.login-header {
  margin-bottom: 2rem;
  text-align: center;
  color: #333;
}

input[type="email"], input[type="password"] {
  width: 100%;
  padding: 10px;
  margin-top: 8px;
  margin-bottom: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  width: 100%;
  padding: 10px 20px;
  background-color: #405983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #364b73;
}

.button-loading {
  background-color: #aaa;
}

button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}
</style>
