<?php
$token_file = "/boot/config/plugins/cloudflared/token.txt";
$rc_script = "/etc/rc.d/rc.cloudflared";

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['token'])) {
        file_put_contents($token_file, trim($_POST['token']));
    }
    if (isset($_POST['action'])) {
        $action = $_POST['action'];
        shell_exec("$rc_script $action");
    }
}

// Get status
$status = trim(shell_exec("$rc_script status"));
$token = file_exists($token_file) ? file_get_contents($token_file) : "";
?>

<h2>Cloudflared Tunnel</h2>
<form method="post">
    <label>Cloudflare Tunnel Token:</label><br>
    <input type="text" name="token" value="<?php echo htmlspecialchars($token); ?>" size="60">
    <input type="submit" value="Save Token">
</form>

<h3>Status: <?php echo $status; ?></h3>
<form method="post">
    <button name="action" value="start">Start</button>
    <button name="action" value="stop">Stop</button>
    <button name="action" value="restart">Restart</button>
</form>
