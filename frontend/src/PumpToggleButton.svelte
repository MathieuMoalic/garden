<script>
    import { onMount } from "svelte";

    let pumpOn = false;
    let togglePump = async () => {
        pumpOn = await getPumpStatus();
        if (pumpOn) {
            await fetch("./api/pump-off", { method: "get" }).then(
                () => (pumpOn = false)
            );
        } else {
            await fetch("./api/pump-on", { method: "get" }).then(
                () => (pumpOn = true)
            );
        }
        getPumpStatus();
    };
    let getPumpStatus = async () => {
        pumpStatus = await fetch("./api/pump-status").then((res) => res.json());
        return pumpStatus.status;
    };
    let pumpStatus;

    onMount(async () => {
        pumpOn = await getPumpStatus();
    });
</script>

<div class="outer">
    {#await pumpStatus}
        <p>...getting the pump status</p>
    {:then}
        <div class="pump-label">Water Pump</div>
        <label class="switch">
            <input
                type="checkbox"
                bind:checked={pumpOn}
                on:change={togglePump}
            />
            <span class="slider round" />
        </label>
    {:catch error}
        <p style="color: red">{error.message}</p>
    {/await}
</div>

<style>
    .pump-label {
        margin: 1rem;
    }
    div {
        align-items: center;
        display: flex;
        justify-content: center;
    }
    .switch {
        position: relative;
        display: inline-block;
        width: 60px;
        height: 34px;
    }

    /* Hide default HTML checkbox */
    .switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    /* The slider */
    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        -webkit-transition: 0.4s;
        transition: 0.4s;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 26px;
        width: 26px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        -webkit-transition: 0.4s;
        transition: 0.4s;
    }

    input:checked + .slider {
        background-color: #167b43;
    }

    input:focus + .slider {
        box-shadow: 0 0 1px #167b43;
    }

    input:checked + .slider:before {
        -webkit-transform: translateX(26px);
        -ms-transform: translateX(26px);
        transform: translateX(26px);
    }

    /* Rounded sliders */
    .slider.round {
        border-radius: 34px;
    }

    .slider.round:before {
        border-radius: 50%;
    }
</style>
