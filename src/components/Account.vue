<script setup>
import { supabase } from '@/supabase'
import { onMounted, ref } from 'vue'
import {get_user} from "@/authentication";

const loading = ref(true)

// Account properties
const email = ref('')
const vorname = ref('')
const username = ref('')
const website = ref('')
const avatar_url = ref('')

onMounted(async () => {
  await getProfile()
})

async function getProfile() {    
    try {
      const user = await get_user();
      console.log(user)

        const { data, error, status } = await supabase
            .from('profiles')
            .select(`username, website, avatar_url`)
            .eq('id', user.id)
            .single()

        if (error && status !== 406) throw error

        if (data) {
            email.value = user.email
            username.value = data.username
            website.value = data.website
            avatar_url.value = data.avatar_url
        }

    } catch (error) {
        alert(error.message)
    } finally {
        loading.value = false
    }
}

async function updateProfile() {
    try {
        loading.value = true
        const user = await get_user();

        const updates = {
            id: user.id,
            username: username.value,
            website: website.value,
            avatar_url: avatar_url.value,
            updated_at: new Date(),
        }

        const { error } = await supabase.from('profiles').upsert(updates)

        if (error) throw error
    } catch (error) {
        alert(error.message)
    } finally {
        loading.value = false
    }
}
</script>

<template>
  <article class="format">
  <h1>Account</h1>
  <form class="form-widget" @submit.prevent="updateProfile">
      <div class="flex">
          <label for="email" class="label">Email</label>
          <input id="email" type="text" v-model="email" class="input" disabled />
      </div>
      <div class="flex">
          <label for="vorname" class="label">Vorame</label>
          <input id="vorname" type="text" v-model="website" class="input" />
      </div>
      <div class="flex">
        <label for="username" class="label">Username</label>
        <input id="username" type="text" v-model="username" class="input" />
      </div>
    <h2>Settings</h2>
      <div class="flex">
        <label for="passwort" class="label">passwort</label>
        <input id="passwort" type="text" v-model="website" class="input"/>
      </div>
      <div class="flex">
        <label for="einschränkungen" class="label">einschränkungen</label>
        <input id="einschränkungen" type="text" v-model="website" class="input"/>
      </div>

    <div class="flex">
      <div>
        <h2>Hobbies</h2>
        <div class="flex">
          <label for="hobbies" class="label">hobbies</label>
          <input id="hobbies" type="text" v-model="website" class="input"/>
        </div>
      </div>
      <div>
        <h2>Interessen</h2>
        <div class="flex">
          <label for="interessen" class="label">passwort</label>
          <input id="interessen" type="text" v-model="website" class="input"/>
        </div>
      </div>
    </div>


      <div>
          <input type="submit" class="button primary block" :value="loading ? 'Loading ...' : 'Update'"
              :disabled="loading" />
      </div>

  </form>
  </article>
</template>

<style scoped>
.format {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-top: 20px;
}

.form-widget{
  width: 100%;
  margin: 0 auto;
  padding: 20px;
  border-radius: 4px;
}

.form-widget div{
  margin-bottom: 10px;
}

.flex{
  display: flex;
  flex-direction: row;
  justify-content: space-evenly;}

.label {
  font-family: 'Roboto', sans-serif;
  color: #211230;
  font-size: 18px;
  margin-bottom: 5px;
  margin-right: 10px;
}

.input {
  width: 100%;
  padding: 10px;
  margin-bottom: 20px;
  border-radius: 4px;
  border: none;
}

</style>