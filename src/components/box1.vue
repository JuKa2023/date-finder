<template>
    <article>
        <section class="cardNotClick">
            <div>
                <h2 class="activity"> Aktivität </h2>
                <p> Kurzbeschreibung der Dates </p>
            </div>
            <img src="/img/Platzhalter.png" alt="illustration der Aktivität">
            <div class="chips">
                <div class="chip">
                    <span>Active</span>
                </div>
                
                <div class="chip">
                    <span>Outside</span>
                </div>
                
            </div>
        </section>
    </article>
</template>


<Style>
    .cardNotClick{
        background-color: #fefafd;
        padding: 10px 20px;
        margin: auto;
        font-family: 'poppins bold', sans-serif;
        max-width: 30%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        border-radius: 10px;
    }

.chips{
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
}
    .chip{
        display: inline-block;
        padding: 0 25px;
        height: 40px;
        font-size: 16px;
        line-height: 40px;
        border: #7A798C 1px solid;
        border-radius: 25px;
        background-color: #ffffff;
        margin: 5px;
        cursor: default;
        color: #7A798C;
    }
    .activity{
        margin-bottom: 0px;
    }
</Style>
