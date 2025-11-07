const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(); // Uses project's credentials automatically

// Callable function - secure and easy to call from Flutter
exports.sendNotification = functions.https.onCall(async (data, context) => {
    // Optional: require authenticated user
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated to send notifications.');
    }

    // Validate input
    const { token, title, body, dataPayload } = data || {};
    if (!token || !title) {
        throw new functions.https.HttpsError('invalid-argument', 'token and title are required.');
    }

    const message = {
        token,
        notification: {
            title,
            body: body || '',
        },
        data: dataPayload || {}, // optional custom key-value pairs
        android: {
            priority: 'high',
        },
        apns: {
            headers: {
                'apns-priority': '10',
            },
        },
    };

    try {
        const res = await admin.messaging().send(message);
        return { success: true, messageId: res };
    } catch (error) {
        console.error('FCM send error', error);
        throw new functions.https.HttpsError('internal', 'Failed to send message.');
    }
});
