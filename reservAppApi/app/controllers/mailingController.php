<?php
require(ROOT .'/fpdf186/fpdf.php');


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once(ROOT . 'PHPMailer/src/Exception.php');
require_once(ROOT . 'PHPMailer/src/PHPMailer.php');
require_once(ROOT . 'PHPMailer/src/SMTP.php');

// Récupération des données JSON envoyées
$json = file_get_contents('php://input');
$data = json_decode($json, true);

// Vérification des données reçues
if (!isset($data['email']) || !isset($data['nom']) || !isset($data['reservation'])) {
    http_response_code(400);
    echo json_encode(["error" => "Données incomplètes"]);
    exit;
}

// Fonction pour générer le PDF
function generatePDF($data) {
    $pdf = new FPDF();
    $pdf->AddPage();
    $pdf->SetFont('Arial','B',16);
    $pdf->Cell(40,10,'Facture de réservation');
    $pdf->Ln(20);
    $pdf->SetFont('Arial','',12);
    $pdf->Cell(0,10,'Nom: '.$data['nom']);
    $pdf->Ln();
    $pdf->Cell(0,10,'Date de réservation: '.$data['reservation']['dateDebut']);
    $pdf->Ln();
    $pdf->Cell(0,10,'Montant: '.$data['reservation']['montant'].' €');
    
    $pdfContent = $pdf->Output('S');
    return $pdfContent;
}

// Générer le PDF
$pdfContent = generatePDF($data);

// Envoyer l'email avec le PDF en pièce jointe
$mail = new PHPMailer(true);

try {
    //Configuration du serveur
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';  // Remplacez par votre serveur SMTP
    $mail->SMTPAuth   = true;
    $mail->Username   = 'votre_email@gmail.com';  // Remplacez par votre email
    $mail->Password   = 'votre_mot_de_passe';  // Remplacez par votre mot de passe
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;

    //Destinataires
    $mail->setFrom('votre_email@gmail.com', 'Votre Nom');
    $mail->addAddress($data['email'], $data['nom']);

    // Contenu
    $mail->isHTML(true);
    $mail->Subject = 'Confirmation de réservation';
    $mail->Body    = 'Merci pour votre réservation. Veuillez trouver ci-joint votre facture.';

    // Pièce jointe
    $mail->addStringAttachment($pdfContent, 'facture.pdf');

    $mail->send();
    echo json_encode(["message" => "Email envoyé avec succès"]);
} catch (Exception $e) {
    echo json_encode(["error" => "Erreur lors de l'envoi de l'email: {$mail->ErrorInfo}"]);
}
?>
