const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.getUserEmail = functions.https.onCall(async (data, context) => {
  const uid = data.query.uid;
  try {
    const userRecord = await admin.auth().getUser(uid);
    const userEmail = userRecord.email;
    return context.status(200).json({ email: userEmail });

  } catch (error) {
    throw new functions.https.HttpsError('failed-precondition', error.message);
  }
});
