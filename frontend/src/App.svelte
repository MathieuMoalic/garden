<script>
  import PumpToggleButton from "./PumpToggleButton.svelte";
  import Cam from "./Cam.svelte";
  import PumpStatus from "./PumpStatus.svelte";
  import History from "./History.svelte";
</script>

<main>
  <div class="status">
    <PumpStatus />
  </div>
  <div class="pump">
    <PumpToggleButton />
  </div>
  <div class="cam">
    <Cam />
  </div>
  <div class="history">
    <History />
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
    grid-template-rows: 1fr 1fr 2fr 1fr;
    grid-template-areas:
      "PumpToggle PumpToggle PumpToggle PumpToggle"
      "PumpStatus PumpStatus PumpStatus PumpStatus"
      "Cam Cam Cam Cam"
      "History History History History";
    grid-gap: 0px;
    overflow: hidden;
    height: 100%;
  }
  main > div {
    text-align: center;
    /* margin: 20px 0; */
    font-size: 30px;
  }
  .pump {
    grid-area: PumpToggle;
  }
  .status {
    grid-area: PumpStatus;
  }
  .cam {
    grid-area: Cam;
  }
  .history {
    grid-area: History;
  }
</style>
