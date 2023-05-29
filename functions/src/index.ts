import vision from "@google-cloud/vision";
import * as functions from "firebase-functions";

const client = new vision.ImageAnnotatorClient();

export const annotateImage =
    functions.https.onCall(async (data: Buffer, context) => {
        if (!context.auth) {
            throw new functions.https.HttpsError(
                "unauthenticated",
                "annotateImageは認証時に呼び出す必要があります。"
            );
        }
        try {
            const request = {
                image: {
                    content: data,
                },
                features: [
                    {
                        type: "TEXT_DETECTION",
                    },
                ],
            };
            const result = await client.annotateImage(request);
            const fullText = result[0].fullTextAnnotation?.text;
            functions.logger.log("🎉" + fullText);
            return fullText;
        } catch (error: any) {
            functions.logger.log("🔥" + error);
            throw new functions.https.HttpsError(
                "internal",
                error.message
            );
        }
    });
