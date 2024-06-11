<script setup>
const backgroundImgUrl = new URL('../assets/img/background.svg', import.meta.url).href

document.body.style.backgroundImage = `url(${backgroundImgUrl})`
document.body.style.backgroundSize = 'cover'
document.body.style.backgroundRepeat = 'no-repeat'
document.body.style.backgroundAttachment = 'fixed'
</script>

<template>
	<div class="backdrop">
		<section class="hero-section">
			<h1>Entdecke neue Wege zu daten!</h1>
			<p>
				Beginne dein Abenteuer mit kreativen Dating-Ideen, die auf die Jahreszeit und deine
				Interessen abgestimmt sind. Unsere Plattform bietet ein nahtloses Erlebnis, um jeden
				gemeinsamen Moment besonders zu machen.
			</p>
			<RouterLink class="shadow-button" to="/login">Jetzt starten</RouterLink>
			<div class="image-container">
				<img src="/src/assets/img/paaramplanen.webp" alt="Paar plant Dates" />
			</div>
		</section>

		<section class="features-section">
			<h2>Warum Uns Wählen?</h2>
			<div class="feature">
				<h3>Kreativität auf Knopfdruck</h3>
				<p>
					Entdecke eine Vielzahl von einzigartigen Dating-Vorschlägen, die kreativ und individuell
					auf eure Interessen zugeschnitten sind.
				</p>
			</div>
			<div class="feature">
				<h3>Einfache Planung</h3>
				<p>
					Unsere intuitive Plattform erleichtert die Planung und Organisation, damit ihr mehr Zeit
					zusammen geniessen könnt.
				</p>
			</div>

			<div class="feature">
				<h3>Persönliche Empfehlungen</h3>
				<p>
					Erhalte maßgeschneiderte Vorschläge basierend auf euren Vorlieben und gemeinsamen
					Interessen, um jede Verabredung unvergesslich zu machen.
				</p>
			</div>
		</section>

		<section class="testimonials-section">
			<h2>Was Unsere Nutzer Sagen</h2>
			<div class="testimonial">
				<p>
					„Dank dieser Plattform haben wir innovative und aufregende Date-Ideen entdeckt, die unsere
					Beziehung bereichert haben!“
				</p>
				<cite>– Julia & Mark</cite>
			</div>
		</section>

		<section class="final-cta-section">
			<h2>Bereit, das Dating neu zu erleben?</h2>
			<RouterLink class="shadow-button" to="/login">Starte Jetzt</RouterLink>
		</section>
	</div>
</template>

<style scoped>
.backdrop {
	backdrop-filter: blur(10px);
	height: 100%;
}
.hero-section {
	color: #211230;
	padding: 10px 20px 10px 20px;
	text-align: center;
}

.hero-section h1 {
	font-size: 3.5rem;
	font-weight: bold;
	margin-bottom: 30px;
}

.hero-section p {
	font-size: 1.6rem;
	color: #211230;
	max-width: 650px;
	margin: 30px auto;
}

.image-container img {
	max-width: 85%;
	height: auto;
	margin-top: 40px;
	border-radius: 12px;
}

.features-section,
.testimonials-section {
	background-color: rgba(255, 255, 255, 0.95);
	color: #333;
	padding: 30px 20px;
	margin: 0px 30px 0px 30px;
	text-align: center;
}

.features-section {
	margin-top: 30px;
}

.final-cta-section {
	color: #333;
	padding: 50px 20px;
	margin: 0px 30px 0px 30px;
	text-align: center;
}

.features-section h2,
.testimonials-section h2,
.final-cta-section h2 {
	font-size: 2.5rem;
	margin-bottom: 30px;
}

.feature,
.testimonial {
	margin-bottom: 20px;
}

.feature p,
.testimonial p,
.testimonial cite {
	font-size: 1.2rem;
	max-width: 600px;
	margin: 10px auto;
	line-height: 1.6;
}

.testimonial cite {
	display: block;
	margin-top: 10px;
	font-style: normal;
	color: #666;
}

.final-cta-section h2 {
	color: #211230;
}
</style>
