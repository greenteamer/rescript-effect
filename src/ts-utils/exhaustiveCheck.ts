export const exhaustiveCheck = (value: never): never => {
  throw new Error(
    `Unhandled discriminated union member: ${JSON.stringify(value)}`,
  );
};

export const neverError = (error: Error): never => {
  throw error;
};
