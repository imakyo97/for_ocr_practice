import * as functions from "firebase-functions";

export const annotateImage = functions.https.onCall((data, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "annotateImageは認証時に呼び出す必要があります。"
        );
    }
});
