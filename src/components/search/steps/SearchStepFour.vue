<template>
	<div class="content-container">
		<h2>Wann würdest du gerne auf ein Date gehen?</h2>
		<p>
			Beachte dabei, dass bestimmte Aktivitäten nicht immer durchgeführt werden können. Ideen, die
			immer umgesetzt werden können, werden durch deine Auswahl nicht eingeschränkt.
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

const morgenImgUrl = new URL('/src/assets/img/searchsteps/morgen.svg', import.meta.url).href
const nachmittagImgUrl = new URL('/src/assets/img/searchsteps/nachmittag.svg', import.meta.url).href
const abendImgUrl = new URL('/src/assets/img/searchsteps/abend.svg', import.meta.url).href
const nachtImgUrl = new URL('/src/assets/img/searchsteps/nacht.svg', import.meta.url).href

const options = ref([
	{ text: 'Morgen', img: morgenImgUrl, color: '#394263' },
	{ text: 'Nachmittag', img: nachmittagImgUrl, color: '#F8D5A8' },
	{ text: 'Abend', img: abendImgUrl, color: '#A1C6EA' },
	{ text: 'Nacht', img: nachtImgUrl, color: '#8A6353' },
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

.activity{
	height: 70px;
}

.top{
	padding: 10px 10px;
	width: calc(100% - 20px);
}
.bildCard{
margin: 10px 0 0 0;
}
/* Your CSS here or in the global stylesheet */
</style>
