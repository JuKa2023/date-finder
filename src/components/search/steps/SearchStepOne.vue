<template>
	<div class="content-container">
		<h2>Welche Arten von Dates suchst du?</h2>
		<p>
			Umso mehr Angaben du bestätigst, umso besser kann deine Idee auf dich zugeschnitten werden.
		</p>
		<article class="options-container">
			<div
				v-for="option in options"
				:key="option.text"
				@click="selectOption(option)"
				class="cardClickable"
			>
				<div class="top">
					<div>
						<h3 class="activity">{{ option.text }}</h3>
					</div>
					<img class="bildCard" :src="option.img" :alt="`illustration of ${option.text}`" />
				</div>
				<div class="farbbox" :style="{ backgroundColor: option.color }">
					<img class="logo" src="/src/assets/img/logo.svg" alt="logo related to the activity" />
				</div>
			</div>
		</article>
		<button @click="selectOption({ text: 'spielt keine Rolle' })" class="shadow-button">
			egal
		</button>
	</div>
</template>

<script setup>
import { ref, defineEmits } from 'vue'

const emits = defineEmits(['step-complete'])

const aktivImgUrl = new URL('/src/assets/img/searchsteps/aktiv.svg', import.meta.url).href
const lockerImgUrl = new URL('/src/assets/img/searchsteps/locker.svg', import.meta.url).href

const options = ref([
	{ text: 'aktiv', img: aktivImgUrl, color: '#E8A9BF' },
	{ text: 'locker', img: lockerImgUrl, color: '#C4C4C4' },
])

function selectOption(option) {
	if (option.text === 'spielt keine Rolle') {
		for (let i = 0; i < options.value.length; i++) {
			emits('step-complete', options.value[i])
		}
		return
	}
	emits('step-complete', option)
}
</script>

<style scoped>
.activity {
	height: 70px;
}

.top {
	padding: 10px 10px;
	width: calc(100% - 20px);
}
.bildCard {
	margin: 10px 0 0 0;
}
</style>
