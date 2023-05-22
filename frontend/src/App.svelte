<script>
  import PumpToggleButton from "./PumpToggleButton.svelte";
  import Cam from "./Cam.svelte";

  let api = "./api";
</script>

<main>
  <div class="pump">
    <PumpToggleButton />
  </div>
  <div class="cam">
    <Cam />
  </div>
</main>

<style>
  :global(body) {
    margin: 0px;
    border: 0px;
    padding: 0px;
    color: aliceblue;
    font-size: large;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 400;
    background-image: url("/background.avif");
  }
  main {
    display: grid;
    margin: 2rem;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    grid-template-rows: 1fr 1fr 1fr;
    grid-template-areas:
      "PumpToggle PumpToggle PumpToggle PumpToggle"
      "Cam Cam Cam Cam"
      "Cam Cam Cam Cam";
    grid-gap: 10px;
  }
  main > div {
    text-align: center;
    padding: 20px 0;
    font-size: 30px;
  }
  .pump {
    grid-area: PumpToggle;
  }
  .cam {
    grid-area: Cam;
  }
</style>
