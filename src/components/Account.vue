<script setup>
import { supabase } from '@/supabase'
import { onMounted, ref } from 'vue'
import {get_user} from "@/authentication";

const loading = ref(true)

// Account properties
const email = ref('')
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
  <h1>Account</h1>
  <form class="form-widget" @submit.prevent="updateProfile">
      <div>
          <label for="email">Email</label>
          <input id="email" type="text" v-model="email" disabled />
      </div>
      <div>
          <label for="username">Name</label>
          <input id="username" type="text" v-model="username" />
      </div>
      <div>
          <label for="website">Website</label>
          <input id="website" type="url" v-model="website" />
      </div>

      <div>
          <input type="submit" class="button primary block" :value="loading ? 'Loading ...' : 'Update'"
              :disabled="loading" />
      </div>
  </form>
</template>