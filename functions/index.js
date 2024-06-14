

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");


const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.getUserEmail = functions.https.onCall(async (data, context) => {
  const uid = data.uid;
  try {
    const userRecord = await admin.auth().getUser(uid);
    return { email: userRecord.email };
  } catch (error) {
    throw new functions.https.HttpsError('failed-precondition', error.message);
  }
});
