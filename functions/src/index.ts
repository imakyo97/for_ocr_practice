import vision from "@google-cloud/vision";
import * as functions from "firebase-functions";

const client = new vision.ImageAnnotatorClient();

export const annotateImage = functions.https.onCall(async (data, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "annotateImageは認証時に呼び出す必要があります。"
        );
    }
    try {
        return await client.annotateImage(data);
    } catch (error: any) {
        throw new functions.https.HttpsError(
            "internal",
            error.message,
            error.details
        );
    }
});
