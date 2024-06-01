<script setup>
import { onMounted, ref } from 'vue'
import { get_user } from '@/authentication'
import { supabase } from '@/supabase'

import DateList from '@/components/DateList.vue'

const name = ref('')
const savedIdeas = ref([])
const likedIdeas = ref([])
const mostSavedIdeas = ref([])

onMounted(async () => {
	const user = await get_user()
	name.value = user.email

	await updateSavedLikedIdeas(user.id)
	await fetchMostSavedIdeas()
})

async function updateSavedLikedIdeas(userId) {
	const { data, error } = await supabase
		.from('profiles_ideas')
		.select(`
                idea_id,
                liked,
                saved,
                idea (*)
            `)
		.eq('profile_id', userId)

	if (error) throw error

	savedIdeas.value = data.filter((item) => item.saved).map((item) => item.idea)
	likedIdeas.value = data.filter((item) => item.liked).map((item) => item.idea)
}

async function fetchMostSavedIdeas() {
	let { data, error } = await supabase
		.rpc('get_most_saved_ideas');

	if (error) {
		console.error('Error fetching most saved ideas via RPC:', error.message);
		return;
	}

	data.forEach((idea) => {
		idea.id = idea.idea_id;
		delete idea.idea_id;
	});
	data = data.sort((a, b) => b.save_count - a.save_count);
	data = data.filter((idea) => !savedIdeas.value.some((savedIdea) => savedIdea.id === idea.id));
	data = data.slice(0, 3);

	mostSavedIdeas.value = data;
}


</script>

<template>
	<h3>Hallo {{ name }}</h3>

	<section class="format">
		<h2>Gespeicherte Ideen</h2>
		<DateList :date_objects="savedIdeas" />
	</section>

	<section class="format">
		<h2>Beliebteste gespeicherte Ideen</h2>
		<DateList :date_objects="mostSavedIdeas" />
	</section>
</template>

<style scoped></style>