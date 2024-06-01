<script setup>
import { onMounted, ref } from 'vue'
import { get_user } from '@/authentication'
import { supabase } from '@/supabase'

import DateList from '@/components/DateList.vue'

const name = ref('')
const savedIdeas = ref([])
const likedIdeas = ref([])

onMounted(async () => {
	const user = await get_user()
	name.value = user.email

	await updateSavedLikedIdeas(user.id)
})

async function updateSavedLikedIdeas(userId) {
	const { data, error } = await supabase
		.from('profiles_ideas')
		.select(
			`
                idea_id,
                liked,
                saved,
                idea (*)
            `
		)
		.eq('profile_id', userId)

	if (error) throw error

	savedIdeas.value = data.filter((item) => item.saved).map((item) => item.idea)
	likedIdeas.value = data.filter((item) => item.liked).map((item) => item.idea)
}
</script>

<template>
	<h3>Hallo {{ name }}</h3>

	<section class="format">
		<h2>Gespeicherte Ideen</h2>
		<DateList :date_objects="savedIdeas" />
	</section>
</template>

<style scoped></style>
