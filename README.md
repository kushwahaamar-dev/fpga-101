# Cmod A7-35T Rocket Launch Controller Project

## Wiring Guide (Final: Active Low Logic)

**Logic Method:** Active Low  
Buttons are connected to GND (Blue Rail).  
**Red Rail is NOT USED.**  
**Pin 46 is NOT USED.**

### 1. Board Power
- **Ground:** Connect Cmod Pin 25 (Coordinate G24) to the **Blue (-) Rail**.  
  This is the **only** power connection required.

### 2. Button Wiring (Connected to GND)
Place buttons across the breadboard center gap (Rows 30+).

- **Button 1: Start Button**
  - Leg 1 (Top-Left): E30 → Cmod Pin 1 (B1)
  - Leg 4 (Bottom-Right): F32 → Blue Rail (-)

- **Button 2: Reset Button**
  - Leg 1 (Top-Left): E35 → Cmod Pin 2 (B2)
  - Leg 4 (Bottom-Right): F37 → Blue Rail (-)

**Note:** Using diagonal legs (Top-Left to Bottom-Right) ensures the button functions regardless of internal orientation.

### 3. Display & LED Wiring

| Component          | Pin       | Coordinate | Connects To                  | Notes                          |
|--------------------|-----------|------------|------------------------------|--------------------------------|
| Launch LED        | Anode (+) | B3         | Cmod Pin 3                   |                                |
| Launch LED        | Cathode (-) | -         | Blue Rail (GND)              | **Use 330Ω resistor**          |
| 7-Segment Display | Seg A     | B4         | Cmod Pin 4                   |                                |
|                   | Seg B     | B5         | Cmod Pin 5                   |                                |
|                   | Seg C     | B6         | Cmod Pin 6                   |                                |
|                   | Seg D     | B7         | Cmod Pin 7                   |                                |
|                   | Seg E     | B8         | Cmod Pin 8                   |                                |
|                   | Seg F     | B9         | Cmod Pin 9                   |                                |
|                   | Seg G     | B10        | Cmod Pin 10                  |                                |
|                   | Common    | -          | Blue Rail (GND)              | Common Cathode                 |

## How to Program the Cmod A7-35T using Vivado

Follow these steps exactly to upload the Rocket Controller design.

### Phase 1: Create the Project
1. Open Vivado (2020.x or newer recommended).
2. Click **Create Project**.
3. **Project Name:** `RocketLaunch`  
   **Location:** Choose a folder (e.g., on Desktop).
4. Click **Next**.
5. **Project Type:** RTL Project  
   Check **"Do not specify sources at this time"**.
6. Click **Next**.
7. **Default Part** (critical):
   - Preferred: Click **Boards** tab → Search for **Cmod A7-35T** → Select it.
   - Alternative: Click **Parts** tab → Search `xc7a35tcpg236-1` → Select it.
8. Click **Next** → **Finish**.

### Phase 2: Add the Verilog Code
1. In the **Sources** panel, click **+** → **Add Sources**.
2. Select **Add or create design sources** → **Next**.
3. Click **Create File**:
   - File type: Verilog
   - File name: `rocket_controller`
4. Click **OK** → **Finish**.
5. A "Define Module" window appears → Click **OK** → **Yes** (skip port definition).
6. Double-click `rocket_controller.v` to open it.
7. **Delete all content**, then paste the full `rocket_controller.v` code.
8. Press **Ctrl+S** to save.

### Phase 3: Add the Constraints (XDC)
1. Click **+** → **Add Sources** again.
2. Select **Add or create constraints** → **Next**.
3. Click **Create File**:
   - File name: `CmodA7_Master`
4. Click **OK** → **Finish**.
5. Double-click `CmodA7_Master.xdc` to open it.
6. Paste the full `CmodA7_Master.xdc` code.
7. Press **Ctrl+S** to save.

### Phase 4: Build the Bitstream
1. In **Flow Navigator** (left sidebar), scroll to the bottom.
2. Click **Generate Bitstream**.
3. When prompted to launch implementation → Click **Yes**.
4. Wait 2–5 minutes (watch progress: synth_design → opt_design → etc.).
5. When complete: "Bitstream Generation Completed" → Select **Open Hardware Manager** → **OK**.

### Phase 5: Program the Board
1. Connect the Cmod A7 via USB.
2. In Hardware Manager, click **Open Target** → **Auto Connect**.
   (Or use the green menu on the left if the bar is hidden.)
3. Device should appear as `xc7a35t_0`.
4. Right-click `xc7a35t_0` → **Program Device**.
5. Confirm the `.bit` file path → Click **Program**.
6. The blue **DONE** LED on the board should light up.

### Phase 6: Verify It Works!
- **Initial State:** 7-Segment Display shows **9**.
- **Press Button 1 (Start):**
  - Countdown: 9 → 8 → 7 → ... → 0 (exactly 10 seconds).
- **At 0:** Launch LED turns **ON** (Liftoff!).
- **Press Button 2 (Reset):**
  - Instantly returns to **9**, LED turns **OFF**.

Enjoy your rocket launch controller!
