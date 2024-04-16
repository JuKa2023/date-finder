<script setup>

console.log('Hello World, this is the Landing Page');

</script>

<template>
    <section class="content-container">
        <div class="text-container">
            <h1>
                Date Finder
            </h1>
            <p>
                Registrieren Sie sich auf unserer Plattform und erhalten Sie kreative, saisonabhängige Date-Vorschläge, die perfekt auf Ihre Präferenzen abgestimmt sind. Der "Date Generator" hilft Ihnen, der Alltagsroutine zu entfliehen und bietet eine reiche Auswahl an Aktivitäten für jedes Wetter. Erstellen Sie Ihr Benutzerkonto, und genießen Sie personalisierte Erlebnisse, die Ihre Beziehung bereichern. Unsere nutzerfreundliche Webseite basiert auf modernster Technologie für eine optimale Erfahrung. Mit dem Date Generator wird jeder Moment besonders.
            </p>
            <h2>
                Möchtest du es ausprobieren?
            </h2>
            <button class="shadow-button">Click Me</button>
        </div>

        <div class="image-content">
            <img src="/" alt="">
        </div>
    </section>
</template>

<style>
    .content-container {
        display: flex;
        justify-content: space-between; 
        align-items: center; 
        max-width: 750px;
        margin: 0 auto;
    }

    .text-content {
        flex: 1;
        padding-right: 20px;
    }

    .image-content {
        flex: 0 1 300px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    img {
        max-width: 100%;
        height: auto;
    }

</style>