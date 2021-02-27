import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

try {
  admin.initializeApp();
} catch (error) {
  console.error(error);
}

const messaging = admin.messaging();

export const onNewNotification = functions
  .region("europe-west1")
  .firestore.document("/notifications/{notificationId}")
  .onCreate(async (snap, _) => {
    //
    const notification = snap.data() as Notification;
    const order = notification.order;

    const title = `${order.recipe.name} ${order.currentStatus.name} @ ${order.table.name}`;
    const message = {
      notification: {
        title: title,
      },
      data: {
        createdBy: notification.createdBy,
      },
      condition: makeCondition(notification),
    };
    console.log(`Sending message: ${JSON.stringify(message)}`);

    return messaging.send(message);
  });

function makeCondition(notification: Notification) {
  return notification.topicNames.reduce(
    (accumulator, currentValue, currentIndex, _) => {
      if (currentIndex == 0) {
        return `'${currentValue}' in topics`;
      } else {
        return `${accumulator} || '${currentValue}' in topics`;
      }
    },
    ""
  );
}

interface Notification {
  createdBy: string;
  order: Order;
  topicNames: string[];
}

interface Order {
  recipe: Recipe;
  table: Table;
  currentStatus: OrderStatus;
}

interface Recipe {
  name: string;
}

interface Table {
  name: string;
}

interface OrderStatus {
  name: string;
}
