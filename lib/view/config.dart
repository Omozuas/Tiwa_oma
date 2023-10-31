const url = 'http://192.168.137.188:5000/';
const registration = "${url}auth/register";
const loginUser = "${url}auth/login";
const findUser = "${url}auth/:userId";
const SendMail = "${url}otp-register";
const verifyMail = "${url}otp-veryfy";
const sendTransactionOtpMail = "${url}otp-transaction";
const verifyTransactionOtpMail = "${url}otp-veryfyTransaction";
const sendChangePasswordOtpMail = "${url}otp-changePassword";
const verifyChangePasswordOtpMail = "${url}otp-veryfypassword";
const bookAppoinment = "${url}bookings/bookingPayment";
const sendReview = "${url}review/sendReview";
const getVendorById = "${url}vendors/getVendorsbyId/";
const getAllStylist = "${url}auth/find/getAllUsersByAccountTypeDetails/stylist";

//get all review made by a clientid to a particular stlyistId
const getReviewFromClientToStylist =
    "${url}review/getsendReview/client/:stylistId";

// Get all posts made to the stylist for display to a particular client
const getReviewFromStylistToClient =
    "${url}review/stylist/:stylistId/clients/display";
