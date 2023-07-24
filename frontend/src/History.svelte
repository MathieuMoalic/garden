<script>
    import { onMount } from "svelte";

    let pumpHistory = [];

    let getPumpHistory = async () => {
        pumpHistory = await fetch("./api/history").then((res) => res.json());
    };

    onMount(async () => {
        await getPumpHistory();
    });
</script>

<div class="history">
    {#each pumpHistory as line}
        <div class="line">
            {line}
        </div>
    {/each}
</div>

<style>
    .history {
        width: 100%;
    }
    .line {
        font-size: small;
    }
</style>
